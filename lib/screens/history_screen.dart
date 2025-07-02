// lib/screens/history_screen.dart
import 'package:ecowatts/utils/app_routes.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int _selectedTabIndex = 0; // 0: Semaine, 1: Mois, 2: Année
  
  final List<String> _tabs = ['Semaine', 'Mois', 'Année'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        title: const Row(
          children: [
            Icon(Icons.show_chart, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Historique',
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
            // Onglets de navigation (Semaine, Mois, Année)
            _buildNavigationTabs(),
            const SizedBox(height: 20),

            // Graphique de consommation
            _buildChartCard(),
            const SizedBox(height: 15),

            // Détails journaliers
            _buildDailyDetailsCard(),
            const SizedBox(height: 15),

            // Statistiques
            _buildStatisticsCard(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  Widget _buildNavigationTabs() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: _tabs.asMap().entries.map((entry) {
          int index = entry.key;
          String tab = entry.value;
          
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedTabIndex == index 
                      ? AppColors.primaryGreen 
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  tab,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _selectedTabIndex == index 
                        ? Colors.white 
                        : AppColors.lightText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChartCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Placeholder pour le graphique
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFF0F0F0), Color(0xFFE0E0E0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.bar_chart,
                      size: 48,
                      color: Color(0xFF666666),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '📊 Graphique de Consommation',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF666666),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Cette semaine: 89.2 kWh',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF888888),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyDetailsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Détails Journaliers',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 15),
            
            // Aujourd'hui
            _buildHistoryItem(
              day: 'Aujourd\'hui',
              consumption: '18.2 kWh',
              cost: '1,438 FCFA',
              isPositive: true,
            ),
            
            // Hier
            _buildHistoryItem(
              day: 'Hier',
              consumption: '16.7 kWh',
              cost: '1,319 FCFA',
              isPositive: true,
            ),
            
            // Avant-hier
            _buildHistoryItem(
              day: 'Avant-hier',
              consumption: '21.3 kWh',
              cost: '1,683 FCFA',
              isPositive: false,
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem({
    required String day,
    required String consumption,
    required String cost,
    required bool isPositive,
    bool isLast = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                day,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkText,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                consumption,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.lightText,
                ),
              ),
            ],
          ),
          Text(
            cost,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isPositive 
                  ? AppColors.success 
                  : AppColors.error,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Statistiques',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: _buildStatisticItem(
                    value: '12.7',
                    label: 'kWh/jour moyen',
                    color: AppColors.success,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildStatisticItem(
                    value: '+15%',
                    label: 'vs mois dernier',
                    color: AppColors.warning,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticItem({
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.lightText,
            ),
            textAlign: TextAlign.center,
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
        currentIndex: 1, // Historique actif
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
          // Gestion de la navigation entre les onglets
          switch (index) {
            case 0:
               AppRoutes.navigateToDashboard(context);// Navigation vers  Dashboard// 
              break;
            case 1:
               //Déjà sur Historique
              break;
            case 2:
              AppRoutes.navigateToAlerts(context);// Navigation vers Alertes
              break;
            case 3:
             AppRoutes.navigateToTips(context); // Navigation vers conseil
              break;  
            case 4:
             AppRoutes.navigateToProfile(context); // Navigation vers Profil
              break;
          }    
        },
      ),
    );
  }
}