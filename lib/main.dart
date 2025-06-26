import 'package:ecowatts/screens/dashboard_screen.dart';
import 'package:ecowatts/screens/login_screen.dart';
import 'package:ecowatts/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'middleware/auth_middleware.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialiser le service d'authentification
  await AuthService().init();

  runApp(const EcoWatts());
}

class EcoWatts extends StatelessWidget {
  const EcoWatts({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoWatts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: const Color(0xFF2E7D32),
        fontFamily: 'Roboto',
      ),
      home: const AuthWrapper(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const AuthMiddleware(
          child: DashboardScreen(), // Remplace par ton écran dashboard
        ),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkInitialAuth(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '⚡',
                    style: TextStyle(fontSize: 64, color: Color(0xFF2E7D32)),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'EcoWatts',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  SizedBox(height: 32),
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (snapshot.data == true) {
          return const AuthMiddleware(child: DashboardScreen());
        } else {
          return const LoginScreen();
        }
      },
    );
  }

  Future<bool> _checkInitialAuth() async {
    final authService = AuthService();

    if (authService.isAuthenticated) {
      return await authService.validateToken();
    }

    return false;
  }
}
