import 'package:flutter/material.dart';
import 'package:piko/shared/theme/app_colors.dart';

class MerchantLogoutScreen extends StatelessWidget {
  const MerchantLogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ivory,
      appBar: AppBar(
        backgroundColor: AppColors.ivory,
        foregroundColor: AppColors.forest,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          'Log out',
          style: TextStyle(fontSize: 13),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 40),
            Container(
              height: 130,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF0DE),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.waving_hand_outlined,
                size: 60,
                color: AppColors.forest,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Calling it a day?',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'You’ll return to the welcome screen. '
                  'You can open your workspace again whenever you’re ready.',
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Color(0xFF75746E),
              ),
            ),
            const SizedBox(height: 36),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.forest,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text('Yes, log out'),
            ),
            const SizedBox(height: 14),
            OutlinedButton(
              onPressed: () => Navigator.pop(context, false),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.forest,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text('Stay here'),
            ),
          ],
        ),
      ),
    );
  }
}