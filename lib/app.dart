import 'package:flutter/material.dart';

import 'customer/splash/onboarding_s1.dart';
import 'routes/app_routes.dart';
import 'shared/theme/app_theme.dart';

class PikoApp extends StatelessWidget {
  const PikoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Piko',
      theme: AppTheme.lightTheme,
      home: const OnboardingS1(),
      routes: AppRoutes.routes,
    );
  }
}
