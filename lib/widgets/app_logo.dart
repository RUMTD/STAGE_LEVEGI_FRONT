import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class AppLogo extends StatelessWidget {
  final double iconSize;
  final double titleSize;

  const AppLogo({super.key, this.iconSize = 64, this.titleSize = 28});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '⚡',
          style: TextStyle(fontSize: iconSize, color: AppColors.primaryGreen),
        ),
        const SizedBox(height: 16),
        Text(
          'EcoWatts',
          style: TextStyle(
            fontSize: titleSize,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryGreen,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Gérez votre consommation électrique',
          style: TextStyle(fontSize: 16, color: AppColors.lightText),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
