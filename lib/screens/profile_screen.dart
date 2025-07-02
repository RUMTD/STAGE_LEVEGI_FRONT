// lib/screens/profile_screen.dart
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
}