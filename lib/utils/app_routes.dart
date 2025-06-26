import 'package:flutter/material.dart';

import '../screens/dashboard_screen.dart';
import '../screens/login_screen.dart';

class AppRoutes {
  // Noms des routes
  static const String login = '/login';
  static const String signup = '/signup';
  static const String dashboard = '/dashboard';

  // Map des routes
  static Map<String, WidgetBuilder> get routes {
    return {
      login: (context) => const LoginScreen(),
      //signup: (context) => const SignupScreen(),
      dashboard: (context) => const DashboardScreen(),
    };
  }

  // Méthodes de navigation
  static void navigateToLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, login);
  }

  static void navigateToSignup(BuildContext context) {
    Navigator.pushNamed(context, signup);
  }

  static void navigateToLoginFromSignup(BuildContext context) {
    Navigator.pop(context);
  }

  static void navigateToDashboard(BuildContext context) {
    Navigator.pushNamed(context, dashboard);
  }
}
