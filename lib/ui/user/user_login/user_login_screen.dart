import 'package:crafting_custom_woodworks/common_widget/custom_button.dart';
import 'package:crafting_custom_woodworks/common_widget/extentions.dart';
import 'package:crafting_custom_woodworks/resources/color_resources.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../common_widget/CustomTextField.dart';
import '../../../resources/image_resources.dart';

class UserLoginScreen extends StatelessWidget {
  const UserLoginScreen({super.key});

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
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 8,),
                   Image.asset(
                     height: height*0.3,
                     logo,
                   ),

                  // Log in text
                  Text("Log in", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
                  SizedBox(height: paddingVertical),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
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
                        SizedBox(height: paddingVertical),

                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text('Password', style: TextStyle(fontWeight: FontWeight.w500, fontSize: fontSize)),
                          ),
                        ),
                        CustomTextField(hint: "Demo123"),
                      ],
                    ),
                  ),
                  SizedBox(height: paddingVertical),
                  Padding(
                    padding: EdgeInsets.all(paddingHorizontal),
                    child: CustomButton(buttonText: 'Log in', onPressed: ()  {
                      context.go('/user_dashboard');
                    }, color1: buttonColor1, color2: buttonColor2),
                  ),
                  SizedBox(height: paddingVertical),

                  // Social login buttons
                  SizedBox(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Log in with", style: TextStyle(fontWeight: FontWeight.w500, fontSize: fontSize)),
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
                      text: 'No account? ',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: fontSize),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign up',
                          style: TextStyle(fontWeight: FontWeight.bold, color: buttonColor1),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            context.push('/user_sign_up');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                      image: DecorationImage(image: AssetImage(logo)),
                    ),
                  ),
                  Text("Log in", style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize + 2)),
                  SizedBox(height: paddingVertical),
                  SizedBox(height: paddingVertical),
          
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
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
                        SizedBox(height: paddingVertical),
          
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text('Password', style: TextStyle(fontWeight: FontWeight.w500, fontSize: fontSize)),
                          ),
                        ),
                        CustomTextField(hint: "Demo123"),
                      ],
                    ),
                  ),
                  SizedBox(height: paddingVertical),
                  Padding(
                    padding: EdgeInsets.all(paddingHorizontal),
                    child: CustomButton(buttonText: 'Log in', onPressed: () => {}, color1: buttonColor1, color2: buttonColor2),
                  ),
                  SizedBox(height: paddingVertical),
          
                  // Social login buttons
                  SizedBox(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Log in with", style: TextStyle(fontWeight: FontWeight.w500, fontSize: fontSize)),
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
                      text: 'No account? ',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: fontSize),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign up',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            print("Go to Sign Up Screen");
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    else {
      // Web Layout
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(

          child: SafeArea(
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image(image: AssetImage(account1))
                  ),
                  Expanded(child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 300,
                        padding: EdgeInsets.all(paddingVertical),
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(logo)),
                        ),
                      ),
                      Text("Log in", style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize + 4)),
                      SizedBox(height: paddingVertical),
                      // Similar structure for web, but with more spacing
                      SizedBox(height: paddingVertical),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
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
                            SizedBox(height: paddingVertical),

                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text('Password', style: TextStyle(fontWeight: FontWeight.w500, fontSize: fontSize)),
                              ),
                            ),
                            CustomTextField(hint: "Demo123"),
                          ],
                        ),
                      ),
                      SizedBox(height: paddingVertical),
                      Padding(
                        padding: EdgeInsets.all(paddingHorizontal),
                        child: CustomButton(buttonText: 'Log in', onPressed: () => {}, color1: buttonColor1, color2: buttonColor2),
                      ),
                      SizedBox(height: paddingVertical),

                      // Social login buttons
                      SizedBox(
                        width: width,
                        child: Wrap(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Log in with", style: TextStyle(fontWeight: FontWeight.w500, fontSize: fontSize)),
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
                          text: 'No account? ',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: fontSize),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Sign up',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                print("Go to Sign Up Screen");
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
