import 'package:ecowatts/screens/alerts_screen.dart';
import 'package:ecowatts/screens/history_screen.dart';
import 'package:ecowatts/screens/profile_screen.dart';
import 'package:ecowatts/screens/tips_screen.dart';
import 'package:flutter/material.dart';

import '../screens/dashboard_screen.dart';
import '../screens/login_screen.dart';

class AppRoutes {
  // Noms des routes
  static const String login = '/login';
  static const String signup = '/signup';
  static const String dashboard = '/dashboard';
  static const String history = '/history';
  static const String alerts ='/alerts';
  static const String tips = '/tips';
  static const String profile = '/profile';

  // Map des routes
  static Map<String, WidgetBuilder> get routes {
    return {
      login: (context) => const LoginScreen(),
      //signup: (context) => const SignupScreen(),
      dashboard: (context) => const DashboardScreen(),
      history: (context) => const HistoryScreen(),
      alerts: (context) => AlertsScreen(),
      tips: (context) =>const TipsScreen(),
      profile: (context) => const ProfileScreen(),
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
  static void navigateToHistory(BuildContext context) {
  Navigator.pushNamed(context, history);
  } 
 
  static void navigateToAlerts(BuildContext context) {
  Navigator.pushNamed(context, alerts);
  }
  static void navigateToTips(BuildContext context) {
  Navigator.pushNamed(context, tips);
  }
  static void navigateToProfile(BuildContext context) {
  Navigator.pushNamed(context, profile);
  }
}
