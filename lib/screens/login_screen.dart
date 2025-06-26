// ===== lib/screens/login_screen.dart =====
import 'package:ecowatts/screens/signup_screen.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/auth_service.dart';
import '../utils/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    //_emailController.text = "user@example.com";
    //_passwordController.text = "password";
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar verte comme dans ton design
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        title: const Row(
          children: [
            Text('⚡', style: TextStyle(fontSize: 20)),
            SizedBox(width: 10),
            Text(
              'EcoWatts',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),

      // Fond avec gradient
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF667eea), // Bleu clair
              Color(0xFF764ba2), // Violet
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Titre de la page
                      const Text(
                        'Connexion',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Logo et description
                      const Text(
                        '⚡',
                        style: TextStyle(
                          fontSize: 64,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'EcoWatts',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Gérez votre consommation électrique',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF666666),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),

                      // Champ Email
                      _buildInputField(
                        label: 'Email',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.email_outlined,
                      ),
                      const SizedBox(height: 24),

                      // Champ Mot de passe
                      _buildInputField(
                        label: 'Mot de passe',
                        controller: _passwordController,
                        isPassword: true,
                        prefixIcon: Icons.lock_outline,
                        enabled: !_isLoading,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: const Color(0xFF2E7D32),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Bouton de connexion
                      // bouton connexiion pour pouvoir voir le dashbord mais il va falloir modifier
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E7D32),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 3,
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Se connecter',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),

                      /*SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _handleCreateAccount,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E7D32),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          child: const Text(
                            'Se connecter',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),*/
                      const SizedBox(height: 24),

                      // Lien "Créer un compte"
                      TextButton(
                        onPressed: _isLoading ? null : _handleCreateAccount,
                        child: const Text(
                          'Créer un compte',
                          style: TextStyle(
                            color: Color(0xFF2E7D32),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget pour les champs de saisie
  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    bool isPassword = false,
    TextInputType? keyboardType,
    IconData? prefixIcon,
    bool enabled = true,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword? _obscurePassword : false,
          keyboardType: keyboardType,
          enabled: enabled,
          decoration: InputDecoration(
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: const Color(0xFF2E7D32))
                : null,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFE0E0E0),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2E7D32), width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFE0E0E0),
                width: 1.5,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  // Fonction de connexion
  Future<void> _handleLogin() async {

    // Ajout de debug pour vérifier les valeurs
    print('Email: "${_emailController.text}"');
    print('Password: "${_passwordController.text}"');
    print('Email length: ${_emailController.text.length}');
    print('Password length: ${_passwordController.text.length}');

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showSnackBar('Veuillez remplir tous les champs', Colors.red);
      return;
    }
    // Validation email basique
    if (!RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(_emailController.text.trim())) {
      _showSnackBar('Format d\'email invalide', Colors.red);
      return;
    }
    setState(() {
      _isLoading = true;
    });

    try {

      // Ajout de debug avant l'appel API
      print('Tentative de connexion avec:');
      print('Email: ${_emailController.text.trim()}');
      print('Password: ${_passwordController.text}');

      final authResponse = await _authService.login(
        _emailController.text.trim(),
        _passwordController.text,
      );

      _showSnackBar('Connexion réussie !', const Color(0xFF2E7D32));

      // Navigation vers le dashboard après un court délai
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          AppRoutes.navigateToDashboard(context);
        }
      });
    } catch (e) {
      String errorMessage = 'Erreur de connexion';

      // Ajout de debug pour l'erreur
      print('Erreur de connexion: $e');
      print('Type d\'erreur: ${e.runtimeType}');

      if (e is ApiError) {
        errorMessage = _authService.formatValidationErrors(e);
      } else {
        errorMessage = e.toString();
      }

      _showSnackBar(errorMessage, Colors.red);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }

    // Simulation de connexion
    // _showSnackBar('Connexion réussie !', const Color(0xFF2E7D32));

    // Ici tu peux naviguer vers le dashboard
    // Navigator.pushReplacementNamed(context, '/dashboard');
  }

  // Fonction création de compte
  void _handleCreateAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }

  // Fonction pour afficher les messages
  void _showSnackBar(String message, Color color) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
