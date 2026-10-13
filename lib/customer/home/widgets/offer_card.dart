import 'package:flutter/material.dart';
import 'package:piko/shared/theme/app_colors.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(14, 16, 14, 15),
        decoration: BoxDecoration(
          color: AppColors.forest,
          borderRadius: BorderRadius.circular(27),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'YOUR MORNING, UPGRADED',
              style: TextStyle(
                fontFamily: 'Inter',
                color: Color(0xFFD7E7A1),
                fontSize: 10,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Less queue.\nMore you.',
              style: TextStyle(
                fontFamily: 'Inter',
                color: AppColors.ivory,
                fontSize: 29,
                height: 1.02,
                fontWeight: FontWeight.w700,
                letterSpacing: -1.1,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Order ahead with Piko ↗',
              style: TextStyle(
                fontFamily: 'Inter',
                color: AppColors.lime,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
