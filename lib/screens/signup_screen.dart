// ===== lib/screens/register_screen.dart =====
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/user.dart';
import '../services/auth_service.dart';
import '../utils/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    _telephoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar verte comme dans ton design
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
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
                        'Créer un compte',
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
                        'Rejoignez EcoWatts',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF666666),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),

                      // Nom et Prénom sur la même ligne
                      Row(
                        children: [
                          Expanded(
                            child: _buildInputField(
                              label: 'Nom',
                              controller: _nomController,
                              keyboardType: TextInputType.name,
                              prefixIcon: Icons.person_outline,
                              enabled: !_isLoading,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildInputField(
                              label: 'Prénom',
                              controller: _prenomController,
                              keyboardType: TextInputType.name,
                              prefixIcon: Icons.person_outline,
                              enabled: !_isLoading,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Champ Email
                      _buildInputField(
                        label: 'Email',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.email_outlined,
                        enabled: !_isLoading,
                      ),
                      const SizedBox(height: 24),

                      // Champ Téléphone
                      _buildInputField(
                        label: 'Téléphone',
                        controller: _telephoneController,
                        keyboardType: TextInputType.phone,
                        prefixIcon: Icons.phone_outlined,
                        enabled: !_isLoading,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Champ Mot de passe
                      _buildInputField(
                        label: 'Mot de passe',
                        controller: _passwordController,
                        isPassword: true,
                        obscureText: _obscurePassword,
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
                      const SizedBox(height: 24),

                      // Champ Confirmation mot de passe
                      _buildInputField(
                        label: 'Confirmer le mot de passe',
                        controller: _confirmPasswordController,
                        isPassword: true,
                        obscureText: _obscureConfirmPassword,
                        prefixIcon: Icons.lock_outline,
                        enabled: !_isLoading,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: const Color(0xFF2E7D32),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Bouton d'inscription
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleRegister,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E7D32),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
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
                                  'Créer mon compte',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Lien "Déjà inscrit ?"
                      TextButton(
                        onPressed: _isLoading
                            ? null
                            : () => Navigator.pop(context),
                        child: const Text(
                          'Déjà inscrit ? Se connecter',
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

  // Widget pour les champs de saisie (identique à ton login)
  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    bool isPassword = false,
    bool obscureText = false,
    TextInputType? keyboardType,
    IconData? prefixIcon,
    Widget? suffixIcon,
    List<TextInputFormatter>? inputFormatters,
    bool enabled = true,
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
          obscureText: isPassword ? obscureText : false,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
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
            disabledBorder: OutlineInputBorder(
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

  // Fonction d'inscription
  Future<void> _handleRegister() async {
    // Nettoyage des espaces et récupération des valeurs
    final nom = _nomController.text.trim();
    final prenom = _prenomController.text.trim();
    final email = _emailController.text.trim();
    final telephone = _telephoneController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // Debug - Afficher les valeurs pour vérifier
    print('Debug - Valeurs des champs:');
    print('Nom: "$nom" (longueur: ${nom.length})');
    print('Prénom: "$prenom" (longueur: ${prenom.length})');
    print('Email: "$email" (longueur: ${email.length})');
    print('Téléphone: "$telephone" (longueur: ${telephone.length})');
    print(
      'Password: "${password.isNotEmpty ? '[MASQUÉ]' : '[VIDE]'}" (longueur: ${password.length})',
    );

    // Validation des champs
    if (_nomController.text.trim().isEmpty ||
        _prenomController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _telephoneController.text.trim().isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      _showSnackBar('Veuillez remplir tous les champs', Colors.red);
      return;
    }

    // Validation email
    if (!RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(_emailController.text.trim())) {
      _showSnackBar('Format d\'email invalide', Colors.red);
      return;
    }

    // Validation téléphone
    if (_telephoneController.text.length < 9) {
      _showSnackBar(
        'Le numéro de téléphone doit contenir au moins 9 chiffres',
        Colors.red,
      );
      return;
    }

    // Validation mot de passe
    if (_passwordController.text.length < 6) {
      _showSnackBar(
        'Le mot de passe doit contenir au moins 6 caractères',
        Colors.red,
      );
      return;
    }

    // Validation confirmation mot de passe
    if (_passwordController.text != _confirmPasswordController.text) {
      _showSnackBar('Les mots de passe ne correspondent pas', Colors.red);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Debug - Afficher les données envoyées
      print('Debug - Données envoyées au service:');
      print('nom: "$nom"');
      print('prenom: "$prenom"');
      print('email: "$email"');
      print('telephone: "$telephone"');

      final authResponse = await _authService.register(
        nom: _nomController.text.trim(),
        prenom: _prenomController.text.trim(),
        email: _emailController.text.trim(),
        telephone: _telephoneController.text.trim(),
        password: _passwordController.text,
      );

      _showSnackBar('Compte créé avec succès !', const Color(0xFF2E7D32));

      // Navigation vers le dashboard après un court délai
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (mounted) {
          AppRoutes.navigateToLogin(context);
        }
      });
    } catch (e) {
      print('Debug - Erreur capturée: $e');

      String errorMessage = 'Erreur lors de la création du compte';

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
  }

  void _showSnackBar(String message, Color color) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }
}
