// lib/screens/tips_screen.dart
import 'package:ecowatts/utils/app_colors.dart';
import 'package:flutter/material.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        title: const Row(
          children: [
            Text('💡', style: TextStyle(fontSize: 20)),
            SizedBox(width: 8),
            Text('Conseils d\'Économie'),
          ],
        ),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildTipCard(
                    icon: '❄️',
                    title: 'Climatisation Efficace',
                    description: 'Réglez votre climatiseur à 24°C au lieu de 22°C.',
                    savings: '3,000 FCFA/mois',
                  ),
                  const SizedBox(height: 15),
                  _buildTipCard(
                    icon: '🔌',
                    title: 'Appareils en Veille',
                    description: 'Débranchez TV, décodeurs et chargeurs la nuit.',
                    savings: '2,500 FCFA/mois',
                  ),
                  const SizedBox(height: 15),
                  _buildTipCard(
                    icon: '💡',
                    title: 'Éclairage LED',
                    description: 'Remplacez vos ampoules par des LED. Consomment 80% moins.',
                    savings: '4,000 FCFA/mois',
                  ),
                  const SizedBox(height: 15),
                  _buildTipCard(
                    icon: '⚡',
                    title: 'Heures Creuses',
                    description: 'Utilisez gros électroménagers entre 22h et 6h si possible.',
                    savings: '1,500 FCFA/mois',
                  ),
                  const SizedBox(height: 20),

                  _buildSavingsPotentialCard(context),
                ],
              ),
            ),
          ),
          _buildBottomNavigation(),
        ],
      ),
    );
  }

  Widget _buildTipCard({
    required String icon,
    required String title,
    required String description,
    required String savings,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE8F5E8), Color(0xFFC8E6C9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.success, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            icon,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryGreen,
            ),
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                color: AppColors.darkText,
                fontSize: 14,
                height: 1.4,
              ),
              children: [
                TextSpan(text: description),
                const TextSpan(text: '\n'),
                TextSpan(
                  text: 'Économie estimée: $savings',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavingsPotentialCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Votre Potentiel d\'Économie',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.darkText,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    '11,000 FCFA',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'par mois en appliquant ces conseils',
                    style: TextStyle(
                      color: AppColors.lightText,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Réduction de 23% sur votre facture !',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryGreen,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
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

  Widget _buildBottomNavigation() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: AppColors.borderColor, width: 1),
        ),
      ),
      /*child: SafeArea(
        child: Row(
          children: [
            _buildNavItem(
              icon: '📊',
              label: 'Accueil',
              isActive: false,
              onTap: () {
                // Navigation vers Dashboard
              },
            ),
            _buildNavItem(
              icon: '📈',
              label: 'Historique',
              isActive: false,
              onTap: () {
                // Navigation vers Historique
              },
            ),
            _buildNavItem(
              icon: '🚨',
              label: 'Alertes',
              isActive: false,
              onTap: () {
                // Navigation vers Alertes
              },
            ),
            _buildNavItem(
              icon: '💡',
              label: 'Conseils',
              isActive: true,
              onTap: () {
                // Déjà sur la page conseils
              },
            ),
            _buildNavItem(
              icon: '👤',
              label: 'Profil',
              isActive: false,
              onTap: () {
                // Navigation vers Profil
              },
            ),
          ],
          
        ),
      ),*/
    );
  }

  /*Widget _buildNavItem({
    required String icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          color: isActive ? const Color(0xFFF0F8F0) : Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                icon,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isActive ? AppColors.primaryGreen : AppColors.lightText,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                ),
              )
              ,
            ],
          ),
        ),
      ),
    );
  }*/
}