import 'dart:ui';

import 'package:crafting_custom_woodworks/resources/image_resources.dart';
import 'package:crafting_custom_woodworks/ui/onboarding/containter_Image_page.dart';
import 'package:crafting_custom_woodworks/ui/user/user_login/user_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../resources/color_resources.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final _pageController = PageController();
  bool isLast = false;

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(bottom: 80.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade300, Colors.purple.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                isLast = index == 3;
              });
            },
            children: [
              buildContainerImage(
                context,
                buttonColor2,
                "Craft Your Dream Furniture",
                "Create custom wooden furniture with personalized designs and sizes.",
                logo,
              ),
              buildContainerImage(
                context,
                grey,
                "Sustainable Materials",
                "We use eco-friendly and durable wood materials for long-lasting furniture.",
                account1,
              ),
              buildContainerImage(
                context,
                Colors.greenAccent.shade100,
                "Easy Customization",
                "Select styles, colors, and finishes that match your taste and needs.",
                logo,
              ),
              buildContainerImage(
                context,
                Colors.red,
                "Delivered to Your Doorstep",
                "Once your custom woodwork is ready, we ensure safe and reliable delivery to your doorstep.",
                account1,
              ),
            ],
          ),
        ),
        bottomSheet: isLast
            ? Padding(
          padding: const EdgeInsets.all(12.0),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white.withOpacity(0.15), // Glassmorphic effect

            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.transparent,
                  minimumSize: Size(double.infinity, 55),
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool("show", true);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (builder) => UserLoginScreen()));
                },
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(27)),
                    backgroundColor: Colors.deepPurple,
                    minimumSize: Size.fromHeight(50),
                  ),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool("show", true);
                    GoRouter.of(context).go('/');


                  },
                  child: Text(
                    "Get Started",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),

              ),
            ),
          ),
        )
            : Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Skip Button
              AnimatedOpacity(
                opacity: isLast ? 0.5 : 1,
                duration: Duration(milliseconds: 300),
                child: TextButton(
                  onPressed: () {
                    _pageController.jumpToPage(3);
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(fontSize: 18, color: Colors.deepPurple),
                  ),
                ),
              ),
              // Page Indicator
              Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 4,
                  effect: ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 12,
                    expansionFactor: 3,
                    dotColor: Colors.white.withOpacity(0.5),
                    activeDotColor: Colors.deepPurple,
                  ),
                  onDotClicked: (index) {
                    _pageController.animateToPage(index,
                        duration: Duration(milliseconds: 600),
                        curve: Curves.easeInOut);
                  },
                ),
              ),
              // Next Button
              AnimatedOpacity(
                opacity: isLast ? 0.5 : 1,
                duration: Duration(milliseconds: 300),
                child: TextButton(
                  onPressed: () {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 600),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(fontSize: 18, color: Colors.deepPurple),
                  ),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }

}