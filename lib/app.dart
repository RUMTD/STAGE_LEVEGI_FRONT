import 'package:flutter/material.dart';

import 'utils/app_routes.dart';
import 'utils/app_theme.dart';

class EcoWatts extends StatelessWidget {
  const EcoWatts({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoWatts',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
