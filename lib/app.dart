import 'package:flutter/material.dart';
import 'customer/splash/brand_screen.dart';

class PikoApp extends StatelessWidget {
  const PikoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Piko',
      home: const BrandScreen(),
    );
  }
}