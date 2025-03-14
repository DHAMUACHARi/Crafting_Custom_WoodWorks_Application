import 'package:crafting_custom_woodworks/ui/user/user_login/user_login_screen.dart';
import 'package:go_router/go_router.dart';

import '../ui/user/user_dashboard/user_dashboard.dart';
import '../ui/user/user_sign_up/user_sign_up_screen.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const UserLoginScreen(),
      ),GoRoute(
        path: '/user_sign_up',
        builder: (context, state) => const UserSignUpScreen(),
      ),GoRoute(
        path: '/user_dashboard',
        builder: (context, state) => const UserDashboard(),
      ),

    ],
  );
}
