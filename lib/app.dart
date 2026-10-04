import 'package:flutter/material.dart';

import 'customer/splash/onboarding_s1.dart';

class PikoApp extends StatelessWidget {
  const PikoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Piko',
      home: const OnboardingS1(),
    );
  }
}
