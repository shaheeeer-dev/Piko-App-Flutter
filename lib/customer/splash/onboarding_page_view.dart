import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piko/shared/theme/app_colors.dart';

class OnboardingPageModel {
  final String svgAsset;
  final String categoryTag;
  final String headline;
  final String subtext;
  final String buttonText;

  const OnboardingPageModel({
    required this.svgAsset,
    required this.categoryTag,
    required this.headline,
    required this.subtext,
    required this.buttonText,
  });
}

class OnboardingPageView extends StatelessWidget {
  final OnboardingPageModel data;

  const OnboardingPageView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Illustration
        Expanded(
          flex: 12,
          child: SizedBox(
            width: double.infinity,
            child: SvgPicture.asset(
              data.svgAsset,
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ),
        ),

        const SizedBox(height: 10),

        // Category tag
        Text(
          data.categoryTag,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.4,
            color: Color(0xFF6F825C),
          ),
        ),

        const SizedBox(height: 10),

        // Headline
        Text(
          data.headline,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 38,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.4,
            height: 1.08,
            color: AppColors.ink,
          ),
        ),

        const SizedBox(height: 12),

        // Subtext
        Text(
          data.subtext,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.5,
            fontWeight: FontWeight.w400,
            height: 1.45,
            color: Color(0xFF787670),
          ),
        ),
      ],
    );
  }
}
