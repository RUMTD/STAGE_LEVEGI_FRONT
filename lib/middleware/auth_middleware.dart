import 'package:flutter/material.dart';

import '../screens/login_screen.dart';
import '../services/auth_service.dart';

class AuthMiddleware extends StatelessWidget {
  final Widget child;
  final bool requireAuth;

  const AuthMiddleware({
    super.key,
    required this.child,
    this.requireAuth = true,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkAuth(),
      builder: (context, snapshot) {
        // Pendant le chargement
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
              ),
            ),
          );
        }

        // Si l'authentification est requise
        if (requireAuth) {
          if (snapshot.data == true) {
            return child; // Utilisateur authentifié
          } else {
            return const LoginScreen(); // Rediriger vers login
          }
        }

        // Si pas d'authentification requise, afficher le contenu
        return child;
      },
    );
  }

  Future<bool> _checkAuth() async {
    final authService = AuthService();

    // Vérifier si l'utilisateur est déjà connecté
    if (authService.isAuthenticated) {
      // Valider le token côté serveur
      return await authService.validateToken();
    }

    return false;
  }
}
