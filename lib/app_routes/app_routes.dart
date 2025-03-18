import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:crafting_custom_woodworks/ui/onboarding/on_boarding_page.dart';
import 'package:crafting_custom_woodworks/ui/user/user_login/user_login_screen.dart';
import 'package:crafting_custom_woodworks/ui/user/user_dashboard/user_dashboard.dart';
import 'package:crafting_custom_woodworks/ui/user/user_sign_up/user_sign_up_screen.dart';

class AppRoutes {
  static Future<GoRouter> createRouter() async {
    final initialRoute = await determineInitialRoute();
    return GoRouter(
      initialLocation: initialRoute,
      routes: [
        GoRoute(
          path: '/onboard',
          builder: (context, state) => const OnBoardingPage(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const UserLoginScreen(),
        ),
        GoRoute(
          path: '/user_sign_up',
          builder: (context, state) => UserSignUpScreen(),
        ),
        GoRoute(
          path: '/user_dashboard',
          builder: (context, state) => const UserDashboard(),
        ),
      ],
    );
  }

  static Future<String> determineInitialRoute() async {
    final prefs = await SharedPreferences.getInstance();
    bool showOnboarding = prefs.getBool('show') ?? false;
    print("----------------------------> $showOnboarding");

    return showOnboarding ? '/' : '/onboard';
  }
}
