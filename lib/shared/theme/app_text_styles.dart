import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const String fontFamily = 'Inter';

  static const TextStyle headline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: AppColors.ivory,
  );

  static const TextStyle subheadline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.ivory,
  );

  static const TextStyle tagline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 3,
    color: AppColors.ivory,
  );

  // C01 Brand Screen

  static const TextStyle brandLogo = TextStyle(
    fontFamily: fontFamily,
    fontSize: 61,
    fontWeight: FontWeight.w700,
    color: AppColors.lime,
    letterSpacing: -2.4,
    height: 1,
  );

  static const TextStyle brandRegistered = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: AppColors.lime,
  );

  static const TextStyle brandHeadline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: AppColors.ivory,
    height: 1.095,
    letterSpacing: -1.8,
  );

  static const TextStyle brandTagline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 9,
    fontWeight: FontWeight.w400,
    color: Color(0xFFBED0BC),
    letterSpacing: 2,
  );
}