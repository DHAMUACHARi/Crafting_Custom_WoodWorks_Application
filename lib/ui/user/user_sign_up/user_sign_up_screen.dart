import 'package:crafting_custom_woodworks/common_widget/extentions.dart';
import 'package:crafting_custom_woodworks/ui/user/user_sign_up/user_sign_up_bloc/user_sign_up_bloc.dart';
import 'package:crafting_custom_woodworks/ui/user/user_sign_up/user_sign_up_bloc/user_sign_up_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import '../../../common_widget/CustomTextField.dart';
import '../../../common_widget/ProgressIndicatorWidget.dart';
import '../../../common_widget/custom_button.dart';
import '../../../resources/color_resources.dart';
import '../../../resources/image_resources.dart';
class UserSignUpScreen extends StatefulWidget {
  const UserSignUpScreen({super.key});

  @override
  State<UserSignUpScreen> createState() => _UserSignUpScreenState();
}

class _UserSignUpScreenState extends State<UserSignUpScreen> {
  int curentStep=-1;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final isMobile = context.isMobile();
    final isTablet = context.isTablet();
    double paddingHorizontal = width * 0.05;
    double paddingVertical = height * 0.02;
    double fontSize = isMobile ? 16 : (isTablet ? 18 : 20);

    if (isMobile) {
      return BlocProvider(
  create: (context) => UserSignUpBloc(),
  child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<UserSignUpBloc, UserSignUpState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [

                  Image.asset(
                    height: height*0.4,
                    account1,
                    fit: BoxFit.fitHeight,
                  ),

                  // Create account text
                  Text("Create account", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
                  SizedBox(height: paddingVertical),
                  ProgressIndicatorWidget(
                    currentStep: curentStep,
                    totalSteps: 5,
                    stepLabels: ['Email', 'Name', 'Birthday', 'Gender', 'Pass'],
                  ),
                  SizedBox(height: paddingVertical),
                  if(curentStep==-1)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: paddingHorizontal,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text('Email', style: TextStyle(fontWeight: FontWeight.w500, fontSize: fontSize)),
                          ),
                        ),
                        CustomTextField(hint: "Demo123@gmail.com"),

                      ],
                    ),
                  ),
                  if(curentStep==0)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('Your Full Name', style: TextStyle(fontWeight: FontWeight.w500, fontSize: fontSize)),
                            ),
                          ),
                          CustomTextField(hint: "Dhamu"),

                        ],
                      ),
                    ),
                  if(curentStep==1)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('Date of birth', style: TextStyle(fontWeight: FontWeight.w500, fontSize: fontSize)),
                            ),
                          ),
                          CustomTextField(hint: "DD/MM/YYYY",dataType: DataTypes.numeric,),

                        ],
                      ),
                    ),
                  if(curentStep==2)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('Gender', style: TextStyle(fontWeight: FontWeight.w500, fontSize: fontSize)),
                            ),
                          ),
                          CustomTextField(hint: "Select your gender"),

                        ],
                      ),
                    ),
                  if(curentStep==3)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('Password', style: TextStyle(fontWeight: FontWeight.w500, fontSize: fontSize)),
                            ),
                          ),
                          CustomTextField(hint: ""),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('Confirm Password', style: TextStyle(fontWeight: FontWeight.w500, fontSize: fontSize)),
                            ),
                          ),
                          CustomTextField(hint: ""),

                        ],
                      ),
                    ),
                  if (curentStep == 4) // Pin input step
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'OTP Code',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: fontSize,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Pinput(
                            length: 6, // Number of digits to input
                            onCompleted: (pin) {
                              // Handle completed PIN input
                              print('OTP Code: $pin');
                            },
                            defaultPinTheme: PinTheme(
                              width: 56,
                              height: 56,
                              textStyle: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(30, 60, 87, 1),
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:Colors.black
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  SizedBox(height: paddingVertical),
                  Padding(
                    padding: EdgeInsets.all(paddingHorizontal),
                    child: CustomButton(
                        buttonText: curentStep==3 ?"Finish":"Continue",
                        onPressed: () => {
                          setState(() {
                            curentStep++;
                            print(curentStep);
                            if(curentStep==5)
                              {
                                context.go('/');
                              }
                          })
                        }, color1: buttonColor1, color2: buttonColor2),
                  ),
                  SizedBox(height: paddingVertical),

                  // Social login buttons
                  SizedBox(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Sig up with", style: TextStyle(fontWeight: FontWeight.w500, fontSize: fontSize)),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {},
                          child: Image.asset(google, width: 25, height: 30),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {},
                          child: Image.asset(facebook, width: 25, height: 30),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {},
                          child: Image.asset(github, width: 30, height: 40),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
                    child: Divider(thickness: 1),
                  ),
                  SizedBox(height: paddingVertical),

                  // Sign up link
                  RichText(
                    text: TextSpan(
                      text: 'Have an account? ',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: fontSize),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Log in',
                          style: TextStyle(fontWeight: FontWeight.bold, color: buttonColor1),
                          recognizer: TapGestureRecognizer()..onTap = () {
                           context.push('/');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  },
),
      ),
);
    } 
    else if (isTablet) {
      // Tablet Layout
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 300,
                    padding: EdgeInsets.all(paddingVertical),
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(account1)),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      );
    } else {
      // Web Layout
      return BlocProvider(
  create: (context) => UserSignUpBloc(),
  child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<UserSignUpBloc, UserSignUpState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Row(
                children: [
                  Expanded(child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 300,
                        padding: EdgeInsets.all(paddingVertical),
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(account1)),
                        ),
                      ),
                      Text("Create account", style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize + 4)),
                      SizedBox(height: paddingVertical),
                      // Similar structure for web, but with more spacing
                      SizedBox(height: paddingVertical),

                    ],
                  )),
                ],
              ),
            ),
          ),
        );
  },
),
      ),
);
    }
  }
}
