import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:piko/shared/theme/app_colors.dart';
import 'package:piko/shared/theme/app_text_styles.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.forest,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.forest,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.forest,

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight;
            final width = constraints.maxWidth;

            return Stack(
              children: [
                // Piko logo
                Positioned(
                  top: height * 0.095,
                  left: 0,
                  right: 0,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'piko',
                        style: AppTextStyles.brandLogo,
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Text(
                          '®',
                          style: AppTextStyles.brandRegistered,
                        ),
                      ),
                    ],
                  ),
                ),

                // Check circle
                Positioned(
                  top: height * 0.285,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/Background.svg',

                      width: width * 0.500,
                      height: width * 0.500,

                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // Main heading
                Positioned(
                  top: height * 0.585,
                  left: width * 0.20,
                  right: width * 0.20,
                  child: const Text(
                    'Good things.\nLess waiting.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.brandHeadline,
                  ),
                ),

                // Tagline
                Positioned(
                  bottom: height * 0.10,
                  left: 0,
                  right: 0,
                  child: const Text(
                    'ORDER AHEAD. PICK UP HAPPY.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.brandTagline,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}