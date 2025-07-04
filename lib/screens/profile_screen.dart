/*// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkModeEnabled = false;
  bool isNotificationsEnabled = true;
  bool isDataSharingEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        title: const Row(
          children: [
            Icon(Icons.person, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Mon Profil',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // Navigation vers les paramètres
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profil utilisateur
            _buildUserProfileCard(),
            const SizedBox(height: 20),

            // Statistiques rapides
            _buildQuickStatsCard(),
            const SizedBox(height: 20),

            // Actions rapides
            _buildQuickActionsCard(),
            const SizedBox(height: 20),

            // Paramètres
            _buildSettingsCard(),
            const SizedBox(height: 20),

            // À propos
            _buildAboutCard(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildUserProfileCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Avatar et info utilisateur
            Row(
              children: [
                // Avatar
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryGreen,
                        AppColors.primaryGreen.withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 20),

                // Informations utilisateur
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Jean Dupont',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'jean.dupont@email.com',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.lightText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.success.withOpacity(0.3),
                          ),
                        ),
                        child: const Text(
                          'Membre depuis 2023',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.success,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Bouton modifier profil
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Action modifier profil
                },
                icon: const Icon(Icons.edit, size: 18),
                label: const Text('Modifier le profil'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStatsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mes Statistiques',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.darkText,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // Économies totales
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.savings,
                    iconColor: AppColors.success,
                    title: 'Économies',
                    value: '45,000 FCFA',
                    subtitle: 'Ce mois',
                  ),
                ),
                const SizedBox(width: 16),
                
                // Consommation moyenne
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.electric_bolt,
                    iconColor: AppColors.warning,
                    title: 'Consommation',
                    value: '125 kWh',
                    subtitle: 'Moyenne',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // Objectifs atteints
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.emoji_events,
                    iconColor: AppColors.primaryGreen,
                    title: 'Objectifs',
                    value: '8/10',
                    subtitle: 'Atteints',
                  ),
                ),
                const SizedBox(width: 16),
                
                // Jours actifs
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.calendar_today,
                    iconColor: const Color(0xFF2196F3),
                    title: 'Jours actifs',
                    value: '28',
                    subtitle: 'Ce mois',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: iconColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.lightText,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.lightText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Actions Rapides',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.darkText,
              ),
            ),
            const SizedBox(height: 16),
            
            // Première ligne d'actions
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.bar_chart,
                    label: 'Historique',
                    onTap: () => AppRoutes.navigateToHistory(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.lightbulb,
                    label: 'Conseils',
                    onTap: () => AppRoutes.navigateToTips(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Deuxième ligne d'actions
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.notifications,
                    label: 'Alertes',
                    onTap: () => AppRoutes.navigateToAlerts(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.support,
                    label: 'Support',
                    onTap: () {
                      // Action support
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primaryGreen.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.primaryGreen.withOpacity(0.2),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 24,
              color: AppColors.primaryGreen,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.darkText,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Paramètres',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.darkText,
              ),
            ),
            const SizedBox(height: 16),

            // Mode sombre
            _buildSettingItem(
              icon: Icons.dark_mode,
              title: 'Mode sombre',
              subtitle: 'Activer le thème sombre',
              isSwitch: true,
              switchValue: isDarkModeEnabled,
              onSwitchChanged: (value) {
                setState(() {
                  isDarkModeEnabled = value;
                });
              },
            ),

            // Notifications
            _buildSettingItem(
              icon: Icons.notifications,
              title: 'Notifications',
              subtitle: 'Recevoir les alertes',
              isSwitch: true,
              switchValue: isNotificationsEnabled,
              onSwitchChanged: (value) {
                setState(() {
                  isNotificationsEnabled = value;
                });
              },
            ),

            // Partage de données
            _buildSettingItem(
              icon: Icons.share,
              title: 'Partage de données',
              subtitle: 'Aider à améliorer l\'app',
              isSwitch: true,
              switchValue: isDataSharingEnabled,
              onSwitchChanged: (value) {
                setState(() {
                  isDataSharingEnabled = value;
                });
              },
            ),

            // Langue
            _buildSettingItem(
              icon: Icons.language,
              title: 'Langue',
              subtitle: 'Français',
              onTap: () {
                // Action changement de langue
              },
            ),

            // Sécurité
            _buildSettingItem(
              icon: Icons.security,
              title: 'Sécurité',
              subtitle: 'Mot de passe et authentification',
              onTap: () {
                // Action sécurité
              },
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    bool isSwitch = false,
    bool switchValue = false,
    ValueChanged<bool>? onSwitchChanged,
    VoidCallback? onTap,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: isSwitch ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(
                    color: AppColors.borderColor,
                    width: 1,
                  ),
                ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                size: 20,
                color: AppColors.primaryGreen,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.lightText,
                    ),
                  ),
                ],
              ),
            ),
            if (isSwitch)
              Switch(
                value: switchValue,
                onChanged: onSwitchChanged,
                activeColor: AppColors.primaryGreen,
              )
            else
              const Icon(
                Icons.chevron_right,
                color: AppColors.lightText,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'À Propos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.darkText,
              ),
            ),
            const SizedBox(height: 16),

            // Version de l'app
            _buildAboutItem(
              icon: Icons.info,
              title: 'Version',
              value: '1.0.0',
            ),

            // Conditions d'utilisation
            _buildAboutItem(
              icon: Icons.description,
              title: 'Conditions d\'utilisation',
              onTap: () {
                // Action conditions
              },
            ),

            // Politique de confidentialité
            _buildAboutItem(
              icon: Icons.privacy_tip,
              title: 'Politique de confidentialité',
              onTap: () {
                // Action politique
              },
            ),

            // Déconnexion
            _buildAboutItem(
              icon: Icons.logout,
              title: 'Se déconnecter',
              titleColor: Colors.red,
              onTap: () {
                _showLogoutDialog();
              },
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutItem({
    required IconData icon,
    required String title,
    String? value,
    Color? titleColor,
    VoidCallback? onTap,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(
                    color: AppColors.borderColor,
                    width: 1,
                  ),
                ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: titleColor ?? AppColors.primaryGreen,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: titleColor ?? AppColors.darkText,
                ),
              ),
            ),
            if (value != null)
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.lightText,
                ),
              )
            else if (onTap != null)
              const Icon(
                Icons.chevron_right,
                color: AppColors.lightText,
              ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Déconnexion'),
          content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Action de déconnexion
                AppRoutes.navigateToLogin(context);
              },
              child: const Text(
                'Se déconnecter',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        currentIndex: 3, // Profil actif
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Historique',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Alertes',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb_outline),
              //activeIcon: Icon(Icons.lightbulb), // Icône quand sélectionné
              label: 'Conseils',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            activeIcon: Icon(Icons.lightbulb),
            label: 'Profil',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              AppRoutes.navigateToDashboard(context);
              break;
            case 1:
              AppRoutes.navigateToHistory(context);
              break;
            case 2:
              AppRoutes.navigateToAlerts(context);
              break;
            case 3:
             AppRoutes.navigateToTips(context); // Navigation vers conseil
              break;
            case 4:
              // Déjà sur la page Profil
              break;
          }
        },
      ),
    );
  }
}*/

// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../utils/app_colors.dart';
import '../utils/app_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkModeEnabled = false;
  bool isNotificationsEnabled = true;
  bool isDataSharingEnabled = false;
  bool isLoading = true;
  
  // Utilisateur actuel
  User? currentUser;
  String? authToken;
  
  // URL de base de votre API
  static const String baseUrl = 'http://192.168.1.67:8000/api';

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  // Charger le profil utilisateur
  Future<void> _loadUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      final userJson = prefs.getString('user_data');
      
      if (token != null && userJson != null) {
        setState(() {
          authToken = token;
          currentUser = User.fromJson(jsonDecode(userJson));
          isLoading = false;
        });
        
        // Rafraîchir les données depuis le serveur
        await _fetchUserFromServer();
      } else {
        // Rediriger vers la page de connexion si pas de token
        AppRoutes.navigateToLogin(context);
      }
    } catch (e) {
      print('❌ Erreur lors du chargement du profil: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Récupérer les données utilisateur depuis le serveur
  Future<void> _fetchUserFromServer() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/profile'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = User.fromJson(data['utilisateur'] ?? data['user']);
        
        // Sauvegarder les données mises à jour
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_data', jsonEncode(user.toJson()));
        
        setState(() {
          currentUser = user;
        });
      } else {
        print('❌ Erreur lors de la récupération du profil: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Erreur réseau: $e');
    }
  }

  // Mettre à jour le profil utilisateur
  Future<void> _updateUserProfile(Map<String, dynamic> updates) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/user/profile'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(updates),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
final userData = data['data']?['utilisateur'];
if (userData == null) {
  _showErrorMessage("Données utilisateur manquantes dans la réponse.");
  return;
}

final updatedUser = User.fromJson(userData);


        // Sauvegarder les données mises à jour
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_data', jsonEncode(updatedUser.toJson()));
        
        setState(() {
          currentUser = updatedUser;
        });
        
        _showSuccessMessage('Profil mis à jour avec succès');
      } else {
        final error = jsonDecode(response.body);
        _showErrorMessage(error['message'] ?? 'Erreur lors de la mise à jour');
      }
    } catch (e) {
      print('❌ Erreur lors de la mise à jour: $e');
      _showErrorMessage('Erreur de connexion');
    }
  }

  // Changer le mot de passe
Future<void> _changePassword({
  required String currentPassword,
  required String newPassword,
  required String confirmPassword,
}) async {
  // Vérifier que les nouveaux mots de passe correspondent
  if (newPassword != confirmPassword) {
    _showErrorMessage('Les nouveaux mots de passe ne correspondent pas');
    return;
  }

  // Vérifier la longueur du mot de passe
  if (newPassword.length < 6) {
    _showErrorMessage('Le mot de passe doit contenir au moins 6 caractères');
    return;
  }

  try {
    // Afficher un indicateur de chargement
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    final response = await http.put(
      Uri.parse('$baseUrl/user/password'),
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'ancien_mot_de_passe': currentPassword,
        'nouveau_mot_de_passe': newPassword,
        'nouveau_mot_de_passe_confirmation': confirmPassword, // Ajouté pour la validation Laravel
      }),
    );

    // Fermer l'indicateur de chargement
    Navigator.of(context).pop();

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      _showSuccessMessage(responseData['message'] ?? 'Mot de passe modifié avec succès');
      
      // Comme le backend supprime tous les tokens, rediriger vers la page de connexion
      _handleLogout(); // Méthode pour déconnecter l'utilisateur et rediriger
      
    } else {
      final error = jsonDecode(response.body);
      String errorMessage = 'Erreur lors du changement de mot de passe';
      
      if (error['message'] != null) {
        errorMessage = error['message'];
      } else if (error['errors'] != null) {
        // Gérer les erreurs de validation Laravel
        final errors = error['errors'] as Map<String, dynamic>;
        
        // Prioriser l'erreur de l'ancien mot de passe
        if (errors['ancien_mot_de_passe'] != null) {
          errorMessage = errors['ancien_mot_de_passe'][0];
        } else if (errors['nouveau_mot_de_passe'] != null) {
          errorMessage = errors['nouveau_mot_de_passe'][0];
        } else {
          // Prendre la première erreur disponible
          errorMessage = errors.values.first[0] ?? errorMessage;
        }
      }
      
      _showErrorMessage(errorMessage);
    }
  } catch (e) {
    // Fermer l'indicateur de chargement en cas d'erreur
    Navigator.of(context).pop();
    print('❌ Erreur lors du changement de mot de passe: $e');
    _showErrorMessage('Erreur de connexion');
  }
}
// Méthode pour gérer la déconnexion après changement de mot de passe
void _handleLogout() {
  // Supprimer le token local
  // Exemple : SharedPreferences, secure storage, etc.
  
  // Rediriger vers la page de connexion
  Navigator.of(context).pushNamedAndRemoveUntil(
    '/login', // Remplacez par votre route de connexion
    (route) => false,
  );
}

  // Afficher la boîte de dialogue de changement de mot de passe
  void _showChangePasswordDialog() {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    
    bool obscureCurrentPassword = true;
    bool obscureNewPassword = true;
    bool obscureConfirmPassword = true;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text(
            'Changer le mot de passe',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Mot de passe actuel
                  TextField(
                    controller: currentPasswordController,
                    obscureText: obscureCurrentPassword,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe actuel',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureCurrentPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            obscureCurrentPassword = !obscureCurrentPassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Nouveau mot de passe
                  TextField(
                    controller: newPasswordController,
                    obscureText: obscureNewPassword,
                    decoration: InputDecoration(
                      labelText: 'Nouveau mot de passe',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureNewPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            obscureNewPassword = !obscureNewPassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Confirmer le nouveau mot de passe
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: obscureConfirmPassword,
                    decoration: InputDecoration(
                      labelText: 'Confirmer le nouveau mot de passe',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            obscureConfirmPassword = !obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Conseils pour le mot de passe
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Conseils pour un mot de passe sécurisé :',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '• Au moins 6 caractères\n'
                          '• Mélange de lettres et chiffres\n'
                          '• Évitez les mots courants',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                if (currentPasswordController.text.isEmpty ||
                    newPasswordController.text.isEmpty ||
                    confirmPasswordController.text.isEmpty) {
                  _showErrorMessage('Veuillez remplir tous les champs');
                  return;
                }
                
                Navigator.of(context).pop();
                _changePassword(
                  currentPassword: currentPasswordController.text,
                  newPassword: newPasswordController.text,
                  confirmPassword: confirmPasswordController.text,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: Colors.white,
              ),
              child: const Text('Changer'),
            ),
          ],
        ),
      ),
    );
  }

  // Déconnexion
  Future<void> _logout() async {
    try {
      // Appeler l'API de déconnexion
      await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
    } catch (e) {
      print('❌ Erreur lors de la déconnexion: $e');
    }
    
    // Supprimer les données locales
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_data');
    
    // Rediriger vers la page de connexion
    AppRoutes.navigateToLogin(context);
  }

  // Afficher un message de succès
  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.success,
      ),
    );
  }

  // Afficher un message d'erreur
  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        title: const Row(
          children: [
            Icon(Icons.person, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Mon Profil',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _fetchUserFromServer,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _fetchUserFromServer,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Profil utilisateur
              _buildUserProfileCard(),
              const SizedBox(height: 20),

              // Statistiques rapides
              _buildQuickStatsCard(),
              const SizedBox(height: 20),

              // Actions rapides
              _buildQuickActionsCard(),
              const SizedBox(height: 20),

              // Paramètres
              _buildSettingsCard(),
              const SizedBox(height: 20),

              // À propos
              _buildAboutCard(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildUserProfileCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Avatar et info utilisateur
            Row(
              children: [
                // Avatar
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryGreen,
                        AppColors.primaryGreen.withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: currentUser?.hasAvatar == true
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.network(
                            currentUser!.avatarUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.white,
                              );
                            },
                          ),
                        )
                      : const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        ),
                ),
                const SizedBox(width: 20),

                // Informations utilisateur
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentUser?.nomComplet ?? 'Nom non disponible',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        currentUser?.email ?? 'Email non disponible',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.lightText,
                        ),
                      ),
                      if (currentUser?.telephone.isNotEmpty == true) ...[
                        const SizedBox(height: 2),
                        Text(
                          currentUser!.telephone,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.lightText,
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.success.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          'Membre depuis ${_getJoinYear()}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.success,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Bouton modifier profil
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _showEditProfileDialog,
                icon: const Icon(Icons.edit, size: 18),
                label: const Text('Modifier le profil'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Obtenir l'année d'inscription
  String _getJoinYear() {
  final createdAt = currentUser?.createdAt;

  if (createdAt != null && createdAt.isNotEmpty) {
    try {
      final date = DateTime.parse(createdAt);
      return date.year.toString();
    } catch (e) {
      debugPrint("Erreur lors de l'analyse de la date: $e");
    }
  }

  return '2023'; // Valeur par défaut si la date est absente ou invalide
}
  /*String _getJoinYear() {
    if (currentUser?.createdAt != null) {
      try {
        final date = DateTime.parse(currentUser!.createdAt!);
        return date.year.toString();
      } catch (e) {
        return '2023';
      }
    }
    return '2023';
  }*/

  // Dialog pour modifier le profil
  void _showEditProfileDialog() {
    final nomController = TextEditingController(text: currentUser?.nom ?? '');
    final prenomController = TextEditingController(text: currentUser?.prenom ?? '');
    final emailController = TextEditingController(text: currentUser?.email ?? '');
    final telephoneController = TextEditingController(text: currentUser?.telephone ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Modifier le profil'),
        content: SizedBox(
          width: double.maxFinite,
        child: SingleChildScrollView(

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: prenomController,
                decoration: const InputDecoration(
                  labelText: 'Prénom',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: nomController,
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: telephoneController,
                decoration: const InputDecoration(
                  labelText: 'Téléphone',
                  border: OutlineInputBorder(),
                ),
                 keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _updateUserProfile({
                'nom': nomController.text,
                'prenom': prenomController.text,
                'email': emailController.text,
                'telephone': telephoneController.text,
              });
            },
            child: const Text('Sauvegarder'),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mes Statistiques',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.darkText,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // Économies totales
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.savings,
                    iconColor: AppColors.success,
                    title: 'Économies',
                    value: '45,000 FCFA',
                    subtitle: 'Ce mois',
                  ),
                ),
                const SizedBox(width: 16),
                
                // Consommation moyenne
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.electric_bolt,
                    iconColor: AppColors.warning,
                    title: 'Consommation',
                    value: '125 kWh',
                    subtitle: 'Moyenne',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // Objectifs atteints
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.emoji_events,
                    iconColor: AppColors.primaryGreen,
                    title: 'Objectifs',
                    value: '8/10',
                    subtitle: 'Atteints',
                  ),
                ),
                const SizedBox(width: 16),
                
                // Jours actifs
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.calendar_today,
                    iconColor: const Color(0xFF2196F3),
                    title: 'Jours actifs',
                    value: '28',
                    subtitle: 'Ce mois',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: iconColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.lightText,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.lightText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Actions Rapides',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.darkText,
              ),
            ),
            const SizedBox(height: 16),
            
            // Première ligne d'actions
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.bar_chart,
                    label: 'Historique',
                    onTap: () => AppRoutes.navigateToHistory(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.lightbulb,
                    label: 'Conseils',
                    onTap: () => AppRoutes.navigateToTips(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Deuxième ligne d'actions
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.notifications,
                    label: 'Alertes',
                    onTap: () => AppRoutes.navigateToAlerts(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.support,
                    label: 'Support',
                    onTap: () {
                      // Action support
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primaryGreen.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.primaryGreen.withOpacity(0.2),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 24,
              color: AppColors.primaryGreen,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.darkText,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Paramètres',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.darkText,
              ),
            ),
            const SizedBox(height: 16),

            // Mode sombre
            _buildSettingItem(
              icon: Icons.dark_mode,
              title: 'Mode sombre',
              subtitle: 'Activer le thème sombre',
              isSwitch: true,
              switchValue: isDarkModeEnabled,
              onSwitchChanged: (value) {
                setState(() {
                  isDarkModeEnabled = value;
                });
              },
            ),

            // Notifications
            _buildSettingItem(
              icon: Icons.notifications,
              title: 'Notifications',
              subtitle: 'Recevoir les alertes',
              isSwitch: true,
              switchValue: isNotificationsEnabled,
              onSwitchChanged: (value) {
                setState(() {
                  isNotificationsEnabled = value;
                });
              },
            ),

            // Partage de données
            _buildSettingItem(
              icon: Icons.share,
              title: 'Partage de données',
              subtitle: 'Aider à améliorer l\'app',
              isSwitch: true,
              switchValue: isDataSharingEnabled,
              onSwitchChanged: (value) {
                setState(() {
                  isDataSharingEnabled = value;
                });
              },
            ),

            // Langue
            _buildSettingItem(
              icon: Icons.language,
              title: 'Langue',
              subtitle: 'Français',
              onTap: () {
                // Action changement de langue
              },
            ),

            // Sécurité
            _buildSettingItem(
              icon: Icons.security,
              title: 'Sécurité',
              subtitle: 'Mot de passe et authentification',
              onTap: _showChangePasswordDialog,
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    bool isSwitch = false,
    bool switchValue = false,
    ValueChanged<bool>? onSwitchChanged,
    VoidCallback? onTap,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: isSwitch ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(
                    color: AppColors.borderColor,
                    width: 1,
                  ),
                ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                size: 20,
                color: AppColors.primaryGreen,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.lightText,
                    ),
                  ),
                ],
              ),
            ),
            if (isSwitch)
              Switch(
                value: switchValue,
                onChanged: onSwitchChanged,
                activeColor: AppColors.primaryGreen,
              )
            else
              const Icon(
                Icons.chevron_right,
                color: AppColors.lightText,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'À Propos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.darkText,
              ),
            ),
            const SizedBox(height: 16),

            // Version de l'app
            _buildAboutItem(
              icon: Icons.info,
              title: 'Version',
              value: '1.0.0',
            ),

            // Conditions d'utilisation
            _buildAboutItem(
              icon: Icons.description,
              title: 'Conditions d\'utilisation',
              onTap: () {
                // Action conditions
              },
            ),

            // Politique de confidentialité
            _buildAboutItem(
              icon: Icons.privacy_tip,
              title: 'Politique de confidentialité',
              onTap: () {
                // Action politique
              },
            ),

            // Déconnexion
            _buildAboutItem(
              icon: Icons.logout,
              title: 'Se déconnecter',
              titleColor: Colors.red,
              onTap: () {
                _showLogoutDialog();
              },
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutItem({
    required IconData icon,
    required String title,
    String? value,
    Color? titleColor,
    VoidCallback? onTap,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(
                    color: AppColors.borderColor,
                    width: 1,
                  ),
                ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: titleColor ?? AppColors.primaryGreen,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: titleColor ?? AppColors.darkText,
                ),
              ),
            ),
            if (value != null)
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.lightText,
                ),
              )
            else if (onTap != null)
              const Icon(
                Icons.chevron_right,
                color: AppColors.lightText,
              ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Déconnexion'),
          content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _logout();
              },
              child: const Text(
                'Se déconnecter',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        currentIndex: 4, // Profil actif
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Historique',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Alertes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline),
            label: 'Conseils',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              AppRoutes.navigateToDashboard(context);
              break;
            case 1:
              AppRoutes.navigateToHistory(context);
              break;
            case 2:
              AppRoutes.navigateToAlerts(context);
              break;
            case 3:
              AppRoutes.navigateToTips(context);
              break;
            case 4:
              // Déjà sur la page Profil
              break;
          }
        },
      ),
    );
  }
}