import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piko/shared/theme/app_colors.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.rating,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String image;
  final String rating;
  final VoidCallback onTap;

  static const _muted = Color(0xFF748076);
  static const _line = Color(0xFFE1E5DB);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 270,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(27),
          border: Border.all(color: _line, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 138,
              width: double.infinity,
              child: SvgPicture.asset(image, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 13, 14, 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      color: AppColors.ink,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9F0DC),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      '★ $rating',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        color: AppColors.forest,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      color: _muted,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Icon(Icons.schedule_rounded, size: 13, color: _muted),
                      SizedBox(width: 5),
                      Text(
                        'Ready in 10–15 min',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: _muted,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
