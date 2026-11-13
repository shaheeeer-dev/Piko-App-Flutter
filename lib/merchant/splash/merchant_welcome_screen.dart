import 'package:flutter/material.dart';
import '../onboarding/business_setup_screen.dart';
import '../auth/merchant_login_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:piko/shared/theme/app_colors.dart';
import 'package:piko/shared/widgets/piko_button.dart';

class MerchantWelcomeScreen extends StatelessWidget {
  const MerchantWelcomeScreen({super.key});

  void _showNextStep(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ivory,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight > 48
                      ? constraints.maxHeight - 48
                      : 0,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),

                      // Piko logo
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/piko_logo.svg',
                            width: 38,
                            height: 38,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'piko',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 34,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1.4,
                              color: AppColors.ink,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 20, left: 3),
                            child: Text(
                              '®',
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.ink,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),
                      const Text(
                        'FOR THE PEOPLE BEHIND THE COUNTER',
                        style: TextStyle(
                          fontSize: 9,
                          letterSpacing: 1.5,
                          color: Color(0xFF75746E),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Cafe illustration
                      ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: AspectRatio(
                          aspectRatio: 2,
                          child: SvgPicture.asset(
                            'assets/images/cafe_hero.svg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),
                      const Text(
                        'More good orders.\nA calmer counter.',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 28,
                          height: 1.15,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1,
                          color: AppColors.ink,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Your café, your menu, your rhythm. '
                            'Meet Piko for merchants.',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: Color(0xFF75746E),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Information card
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: const Color(0xFFE5E7DE),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(9),
                              decoration: const BoxDecoration(
                                color: Color(0xFFEEF1E7),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.storefront_outlined,
                                color: AppColors.forest,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Built for independent favorites',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.ink,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'A simple way to serve your neighborhood.',
                                    style: TextStyle(
                                      fontSize: 11,
                                      height: 1.4,
                                      color: Color(0xFF75746E),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),
                      const SizedBox(height: 32),

                      PrimaryButton(
                        text: 'Set up your business',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BusinessSetupScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MerchantLoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Merchant log in',
                            style: TextStyle(
                              color: AppColors.forest,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}