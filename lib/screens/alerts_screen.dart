// lib/screens/alerts_screen.dart
import 'package:ecowatts/utils/app_routes.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  bool isOverageAlertsEnabled = true;
  bool isDailyTipsEnabled = true;
  bool isWeeklyReportsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        title: const Row(
          children: [
            Icon(Icons.notifications, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Alertes & Notifications',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Liste des alertes récentes
            _buildRecentAlertsSection(),
            const SizedBox(height: 20),

            // Paramètres des alertes
            _buildAlertSettingsCard(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  Widget _buildRecentAlertsSection() {
    return Column(
      children: [
        // Alerte consommation élevée
        _buildAlertItem(
          icon: '⚠️',
          iconColor: AppColors.warning,
          title: 'Consommation élevée',
          subtitle: 'Votre consommation dépasse la moyenne',
          timeAgo: 'Il y a 2 heures',
          backgroundColor: const Color(0xFFFFF3E0),
          borderColor: AppColors.warning,
        ),

        const SizedBox(height: 10),

        // Conseil d'économie
        _buildAlertItem(
          icon: '💡',
          iconColor: AppColors.primaryGreen,
          title: 'Conseil d\'économie',
          subtitle: 'Éteignez vos appareils en veille',
          timeAgo: 'Hier',
          backgroundColor: const Color(0xFFE8F5E8),
          borderColor: AppColors.primaryGreen,
           onTap: () => AppRoutes.navigateToTips(context),
        ),

        const SizedBox(height: 10),

        // Rapport mensuel
        _buildAlertItem(
          icon: '📊',
          iconColor: const Color(0xFF2196F3),
          title: 'Rapport mensuel',
          subtitle: 'Votre rapport de consommation est prêt',
          timeAgo: 'Il y a 3 jours',
          backgroundColor: const Color(0xFFE3F2FD),
          borderColor: const Color(0xFF2196F3),
          onTap: () => AppRoutes.navigateToHistory(context),
        ),

        const SizedBox(height: 10),

        // Objectif atteint
        _buildAlertItem(
          icon: '🎯',
          iconColor: AppColors.success,
          title: 'Objectif atteint',
          subtitle: 'Félicitations ! Budget respecté cette semaine',
          timeAgo: 'Il y a 1 semaine',
          backgroundColor: const Color(0xFFE8F5E8),
          borderColor: AppColors.success,
          isLast: true,
        ),
      ],
    );
  }

  Widget _buildAlertItem({
    required String icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String timeAgo,
    required Color backgroundColor,
    required Color borderColor,
    bool isLast = false,
    VoidCallback? onTap, // ← PARAMÈTRE AJOUTÉ

  }) {
    return InkWell(
   onTap: onTap,
   borderRadius: BorderRadius.circular(15),
    child: Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: borderColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Icône
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                icon,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(width: 15),

          // Contenu
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
                const SizedBox(height: 4),
                Text(
                  timeAgo,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.lightText,
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    ),
    );
  }

  Widget _buildAlertSettingsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Paramètres des Alertes',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),

            // Alertes de dépassement
            _buildSettingItem(
              title: 'Alertes de dépassement',
              subtitle: 'Notifier quand le budget est dépassé',
              value: isOverageAlertsEnabled,
              onChanged: (bool value) {
                setState(() {
                  isOverageAlertsEnabled = value;
                });
              },
            ),

            const SizedBox(height: 20),

            // Conseils quotidiens
            _buildSettingItem(
              title: 'Conseils quotidiens',
              subtitle: 'Recevoir des conseils d\'économie',
              value: isDailyTipsEnabled,
              onChanged: (bool value) {
                setState(() {
                  isDailyTipsEnabled = value;
                });
              },
            ),

            const SizedBox(height: 20),

            // Rapports hebdomadaires
            _buildSettingItem(
              title: 'Rapports hebdomadaires',
              subtitle: 'Rapport de consommation chaque lundi',
              value: isWeeklyReportsEnabled,
              onChanged: (bool value) {
                setState(() {
                  isWeeklyReportsEnabled = value;
                });
              },
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    bool isLast = false,
  }) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
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
          const SizedBox(width: 15),

          // Switch personnalisé
          GestureDetector(
            onTap: () => onChanged(!value),
            child: Container(
              width: 50,
              height: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: value 
                    ? AppColors.primaryGreen 
                    : Colors.grey[300],
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                alignment: value 
                    ? Alignment.centerRight 
                    : Alignment.centerLeft,
                child: Container(
                  width: 21,
                  height: 21,
                  margin: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
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
        currentIndex: 2, // Alertes actif
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
              activeIcon: Icon(Icons.lightbulb), // Icône quand sélectionné
              label: 'Conseils',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        onTap: (index) {
          // Navigation sera gérée par ta structure de routes
           switch (index) {
            case 0:
               AppRoutes.navigateToDashboard(context);// Navigation vers  Dashboard// 
              break;
            case 1:
               AppRoutes.navigateToHistory(context);//Déjà sur Historique
              break;
            case 2:
              AppRoutes.navigateToAlerts(context);// Navigation vers Alertes
              break;
            case 3:
             AppRoutes.navigateToTips(context); // Navigation vers conseil
              break;
            case 4:
              AppRoutes.navigateToProfile(context);// Navigation vers Profil
              break;
          }    
        },
      ),
    );
  }
}