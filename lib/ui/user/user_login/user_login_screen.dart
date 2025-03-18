import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../Network/service.dart';
import '../../../Network/repository.dart';
import '../../../common_widget/CustomTextField.dart';
import '../../../common_widget/custom_button.dart';
import '../../../common_widget/showCustomDialog.dart';
import '../../../resources/color_resources.dart';
import '../../../resources/image_resources.dart';
import 'bloc/user_login_bloc.dart';
import 'bloc/user_login_event.dart';
import 'bloc/user_login_state.dart';

class UserLoginScreen extends StatelessWidget {
  const UserLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserLoginBloc(repository: Repository(service: Service())),
      child: const UserLoginView(),
    );
  }
}

class UserLoginView extends StatelessWidget {
  const UserLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;
    final isWeb = kIsWeb; // Check if running on the web

    double paddingHorizontal = isWeb ? width * 0.2 : width * 0.05;
    double paddingVertical = height * 0.02;
    double fontSize = isMobile ? 16 : (isTablet ? 18 : 20);

    return BlocConsumer<UserLoginBloc, UserLoginState>(
      listener: (context, state) {
        if (state.status == Status.success) {
          showCustomDialog(
            context: context,
            title: "Login Successful",
            message: "Welcome back!",
            type: CustomDialogType.success,
            onButtonPressed: () => context.go('/user_dashboard'),
          );
        } else if (state.status == Status.error) {
          showCustomDialog(
            context: context,
            title: "Login Failed",
            message: state.error!,
            type: CustomDialogType.error,
          );
        }
      },
      builder: (context, state) {
        final bloc = context.watch<UserLoginBloc>();

        return Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 8),
                          Image.asset(logo, height: isWeb ? height * 0.2 : height * 0.3),
                          const Text("Log in", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
                          SizedBox(height: paddingVertical),
                          EmailField(bloc: bloc, state: state),
                          SizedBox(height: paddingVertical),
                          PasswordField(bloc: bloc, state: state),
                          SizedBox(height: paddingVertical),
                          CustomButton(
                            buttonText: 'Log in',
                            onPressed: () => bloc.add(LoginSubmit()),
                            color1: buttonColor1,
                            color2: buttonColor2,
                          ),
                          SizedBox(height: paddingVertical),
                          SocialLoginOptions(bloc: bloc, fontSize: fontSize),
                          SizedBox(height: paddingVertical),
                          SignUpLink(fontSize: fontSize),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Full-screen loading overlay
            if (state.status == Status.processing)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.7),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 5.0,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

// Separate Widget for Social Login Buttons
class SocialLoginOptions extends StatelessWidget {
  final UserLoginBloc bloc;
  final double fontSize;

  const SocialLoginOptions({super.key, required this.bloc, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Log in with", style: TextStyle(fontWeight: FontWeight.w500, fontSize: fontSize)),
          const SizedBox(width: 10),
          InkWell(
            onTap: () => bloc.add(GoogleLoginEvent()),
            child: Image.asset(google, width: 25, height: 30),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () => bloc.add(FacebookLoginEvent()),
            child: Image.asset(facebook, width: 25, height: 30),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () {},
            child: Image.asset(github, width: 30, height: 40),
          ),
        ],
      ),
    );
  }
}

// Separate Widget for Sign-Up Link
class SignUpLink extends StatelessWidget {
  final double fontSize;

  const SignUpLink({super.key, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'No account? ',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: fontSize),
        children: <TextSpan>[
          TextSpan(
            text: 'Sign up',
            style: TextStyle(fontWeight: FontWeight.bold, color: buttonColor1),
            recognizer: TapGestureRecognizer()..onTap = () => context.push('/user_sign_up'),
          ),
        ],
      ),
    );
  }
}

// Email Field Widget
class EmailField extends StatelessWidget {
  final UserLoginBloc bloc;
  final UserLoginState state;

  const EmailField({super.key, required this.bloc, required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Email", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          CustomTextField(
            hint: "Enter your email",
            errorText: state.emailValidationMsg?.isNotEmpty == true ? state.emailValidationMsg : null,
            onChanged: (val) => bloc.add(EmailInput(val)),
          ),
        ],
      ),
    );
  }
}

// Password Field Widget
class PasswordField extends StatelessWidget {
  final UserLoginBloc bloc;
  final UserLoginState state;

  const PasswordField({super.key, required this.bloc, required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Password", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          CustomTextField(
            hint: "Enter your password",
            errorText: state.passwordValidationMsg?.isNotEmpty == true ? state.passwordValidationMsg : null,
            onChanged: (val) => bloc.add(PasswordInput(val)),
            isPassword: true,
          ),
        ],
      ),
    );
  }
}
