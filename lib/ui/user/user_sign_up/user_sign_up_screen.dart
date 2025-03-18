import 'package:crafting_custom_woodworks/Network/service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:crafting_custom_woodworks/Network/repository.dart';
import 'package:crafting_custom_woodworks/ui/user/user_sign_up/user_sign_up_bloc/user_sign_up_bloc.dart';
import 'package:crafting_custom_woodworks/ui/user/user_sign_up/user_sign_up_bloc/user_sign_up_event.dart';
import 'package:crafting_custom_woodworks/ui/user/user_sign_up/user_sign_up_bloc/user_sign_up_state.dart';
import '../../../common_widget/CustomTextField.dart';
import '../../../common_widget/ProgressIndicatorWidget.dart';
import '../../../common_widget/custom_button.dart';
import '../../../resources/color_resources.dart';
import '../../../resources/image_resources.dart';

class UserSignUpScreen extends StatelessWidget {
  UserSignUpScreen({super.key});

  final UserSignUpBloc userSignUpBloc = UserSignUpBloc(repository: Repository(service: Service()));
  final List<String> stepLabels = ['Email', 'Name', 'Birthday', 'Gender', 'Phone', 'Address', 'Password'];
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => userSignUpBloc,
      child: BlocConsumer<UserSignUpBloc, UserSignUpState>(
        listener: (context, state) {
          if (state.status == Status.success) {
            Future.delayed(Duration(milliseconds: 100), () {
              if (state.currentStep < stepLabels.length) {
                print("Moving to step: ${state.currentStep}");
                pageController.jumpToPage(state.currentStep);
              } else {
                // Ensure the dialog is shown in the UI
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _showSuccessDialog(context);
                });
              }
            });
          } else if (state.status == Status.failure) {
            // Show error message (if needed)
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ?? "Signup Failed")),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(account1, height: 200, fit: BoxFit.fitHeight),
                            SizedBox(height: 20),
                            Text("Create Account", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                            SizedBox(height: 20),
                            ProgressIndicatorWidget(
                              currentStep: state.currentStep,
                              totalSteps: stepLabels.length,
                              stepLabels: stepLabels,
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              height: 200,
                              child: PageView.builder(
                                controller: pageController,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: stepLabels.length,
                                itemBuilder: (context, index) {
                                  return _buildStepContent(index, state);
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            _buildNavigationButtons(context, state),
                            SizedBox(height: 20),
                            _buildLoginLink(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Show loading overlay when API call is in progress
                if (state.status == Status.processing)
                  Container(
                    color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
                    child: Center(
                      child: CircularProgressIndicator(
                        color: buttonColor1, // Use primary button color
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }


  Widget _buildStepContent(int index, UserSignUpState state) {
    switch (index) {
      case 0:
        return EmailField(userSignUpBloc, state);
      case 1:
        return NameFields(userSignUpBloc, state);
      case 2:
        return BirthdayField(userSignUpBloc, state);
      case 3:
        return GenderField(userSignUpBloc, state);
      case 4:
        return PhoneField(userSignUpBloc, state);
      case 5:
        return AddressField(userSignUpBloc, state);
      case 6:
        return PasswordField(userSignUpBloc, state);
      default:
        return Container();
    }
  }

  Widget _buildNavigationButtons(BuildContext context, UserSignUpState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (state.currentStep > 0)
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.grey),
            onPressed: () {
              print("Going back from step: ${state.currentStep}");
              context.read<UserSignUpBloc>().add(UserSignUpPreviousStep());
              pageController.previousPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
        Expanded(
          child: CustomButton(
            buttonText: state.currentStep == stepLabels.length - 1 ? "Finish" : "Continue",
            onPressed: () {
              print("Current step before: ${state.currentStep}");

              if (state.currentStep == stepLabels.length - 1) {
                // If on the last step, trigger the signup API call
                print("Current step submitted");
                context.read<UserSignUpBloc>().add(UserSignUpSubmit());
              } else {
                // Otherwise, move to the next step
                context.read<UserSignUpBloc>().add(UserSignUpNextStep());
              }
            },
            color1: buttonColor1,
            color2: buttonColor2,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Have an account? ',
        style: TextStyle(color: Colors.black, fontSize: 16),
        children: [
          TextSpan(
            text: 'Log in',
            style: TextStyle(fontWeight: FontWeight.bold, color: buttonColor1),
            recognizer: TapGestureRecognizer()..onTap = () => context.push('/'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents dismissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Signup Successful"),
          content: Text("Your account has been created successfully."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.go('/'); // Navigate to login page
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}


class EmailField extends StatelessWidget {
    final UserSignUpBloc bloc;
    final UserSignUpState state;
    EmailField(this.bloc,this.state );

    @override
    Widget build(BuildContext context) {
      return CustomTextField(
        hint: "Enter your email",
        errorText: state.emailError,
        onChanged: (val) => bloc.add(UserSignUpEmail(val)),
      );
    }
  }

  class NameFields extends StatelessWidget {
    final UserSignUpBloc bloc;
    final UserSignUpState state;
    NameFields(this.bloc,this.state);

    @override
    Widget build(BuildContext context) {
      return Column(
        children: [
          CustomTextField(
            hint: "First Name",
            errorText: state.firstNameError,
            onChanged: (val) => bloc.add(UserSignUpName(val)),
          ),
          SizedBox(height: 20,),
          CustomTextField(
            hint: "Last Name",
            errorText: state.lastNameError,
            onChanged: (val) => bloc.add(UserSignUpLastName(val)),
          ),
        ],
      );
    }
  }

  class PhoneField extends StatelessWidget {
    final UserSignUpBloc bloc;
    final UserSignUpState state;
    PhoneField(this.bloc,this.state);

    @override
    Widget build(BuildContext context) {
      return CustomTextField(
        hint: "Enter your phone number",
        errorText: state.phoneNumberError,
        onChanged: (val) => bloc.add(UserSignUpPhoneNumber(val)),
      );
    }
  }

  class AddressField extends StatelessWidget {
    final UserSignUpBloc bloc;
    final UserSignUpState state;
    AddressField(this.bloc,this.state);

    @override
    Widget build(BuildContext context) {
      return CustomTextField(
        hint: "Enter your address",
        errorText: state.addressError,
        onChanged: (val) => bloc.add(UserSignUpAddress(val)),
      );
    }
  }

  class PasswordField extends StatelessWidget {
    final UserSignUpBloc bloc;
    final UserSignUpState state;
    PasswordField(this.bloc,this.state);

    @override
    Widget build(BuildContext context) {
      return CustomTextField(
        hint: "Enter your password",
        errorText: state.passwordError,
        isPassword: true,
        onChanged: (val) => bloc.add(UserSignUpPassword(val)),
      );
    }
  }

  class BirthdayField extends StatelessWidget {
    final UserSignUpBloc bloc;
    final UserSignUpState state;
    BirthdayField(this.bloc,this.state);

    @override
    Widget build(BuildContext context) {
      return CustomTextField(
        hint: "Enter your birthday (YYYY-MM-DD)",
        errorText: state.dobError,
        onChanged: (val) => bloc.add(UserSignUpDob(val)),
      );
    }
  }

class GenderField extends StatelessWidget {
  final UserSignUpBloc bloc;
  final UserSignUpState state;

  GenderField(this.bloc, this.state);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: state.gender.isNotEmpty ? state.gender : null, // Ensure selected gender is displayed
      hint: const Text("Select Gender"),
      items: ["Male", "Female", "Other"].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (val) {
        bloc.add(UserSignUpGender(val!)); // Trigger event when gender is selected
      },
    );
  }
}
