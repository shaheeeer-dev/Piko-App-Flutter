import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:piko/customer/auth/login_screen.dart';
import 'package:piko/customer/splash/onboarding_page_view.dart';
import 'package:piko/shared/theme/app_colors.dart';
import 'package:piko/shared/widgets/dots_indicator.dart';
import 'package:piko/shared/widgets/piko_button.dart';

class OnboardingS1 extends StatefulWidget {
  final int initialPage;
  const OnboardingS1({super.key, this.initialPage = 0});

  @override
  State<OnboardingS1> createState() => _OnboardingS1State();
}

class _OnboardingS1State extends State<OnboardingS1> {
  late final PageController _pageController;
  late int _currentPage;

  final List<OnboardingPageModel> _pages = const [
    OnboardingPageModel(
      svgAsset: 'assets/images/coffee.svg',
      categoryTag: '01 / ORDER AHEAD',
      headline: 'Your favorites.\nMinus the wait.',
      subtext: 'Great coffee and little cravings, ordered\nahead from the places you love.',
      buttonText: 'Next',
    ),
    OnboardingPageModel(
      svgAsset: 'assets/images/shop.svg',
      categoryTag: '02 / PICK UP HAPPY',
      headline: 'Your order.\nYour perfect timing.',
      subtext: 'Pick a time that fits your day. We’ll let you\nknow when it’s ready. Just walk in and enjoy.',
      buttonText: 'Get started',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
    _pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToLogin();
    }
  }

  void _navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ivory,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              // Header: Logo & "Skip ↗"
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo + piko®
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/piko_logo.svg',
                        height: 38,
                        width: 38,
                      ),
                      const SizedBox(width: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'piko',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 34,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1.4,
                              color: AppColors.ink,
                              height: 1.0,
                            ),
                          ),
                          Transform.translate(
                            offset: const Offset(3, -2),
                            child: const Text(
                              '®',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: AppColors.ink,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Skip ↗
                  GestureDetector(
                    onTap: _navigateToLogin,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'Skip',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF75746E),
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_outward_rounded,
                            size: 15,
                            color: Color(0xFF75746E),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Swipeable PageView
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return OnboardingPageView(data: _pages[index]);
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Dots indicator (synced with current page)
              Center(
                child: DotsIndicator(
                  count: _pages.length,
                  currentIndex: _currentPage,
                  spacing: 6,
                ),
              ),

              const SizedBox(height: 24),

              // "Next ->" / "Get started ->" Button
              PrimaryButton(
                text: _pages[_currentPage].buttonText,
                trailing: const Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.lime,
                  size: 22,
                ),
                onPressed: _onNextPressed,
              ),

              const SizedBox(height: 16),

              // "Already a member? Log in"
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Already a member? ',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF7A7974),
                      ),
                    ),
                    GestureDetector(
                      onTap: _navigateToLogin,
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.forest,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
