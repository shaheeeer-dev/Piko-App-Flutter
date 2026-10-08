import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piko/shared/theme/app_colors.dart';
import 'package:piko/shared/widgets/piko_bottom_navigation.dart';

import 'search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _muted = Color(0xFF748076);
  static const _line = Color(0xFFE1E5DB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ivory,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(32, 12, 32, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _TopBar(),
                    const SizedBox(height: 43),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'PICKING UP NEAR',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: _muted,
                                fontSize: 10,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Text(
                                  'Gulberg, Lahore',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: AppColors.ink,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 16,
                                  color: AppColors.ink,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.notifications_none_rounded,
                          color: AppColors.ink,
                          size: 22,
                        ),
                      ],
                    ),
                    const SizedBox(height: 17),
                    const Text(
                      'A good day starts\nwith something good.',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: AppColors.ink,
                        fontSize: 29,
                        height: 1.02,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -1.1,
                      ),
                    ),
                    const SizedBox(height: 17),
                    const _CategoryRow(),
                    const SizedBox(height: 21),
                    const _OfferBanner(),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 300,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.none,
                        children: const [
                          _VenueCard(
                            title: 'Mocca',
                            subtitle: 'Coffee & bakery · 6 min walk',
                            image: 'assets/images/coffee.svg',
                            rating: '4.9',
                          ),
                          SizedBox(width: 18),
                          _VenueCard(
                            title: 'June Coffee',
                            subtitle: 'Coffee & bakery · 8 min walk',
                            image: 'assets/images/Background.svg',
                            rating: '4.8',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            PikoBottomNavigation(
              currentIndex: 0,
              onItemSelected: (index) {
                if (index == 1) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SearchScreen()),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 16,
            color: HomeScreen._muted,
          ),
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Home',
              style: TextStyle(
                fontFamily: 'Inter',
                color: HomeScreen._muted,
                fontSize: 11,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          _CategoryChip('For you', selected: true),
          _CategoryChip('Coffee'),
          _CategoryChip('Bakery'),
          _CategoryChip('Lunch'),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip(this.label, {this.selected = false});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? AppColors.forest : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: selected ? null : Border.all(color: HomeScreen._line),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Inter',
          color: selected ? AppColors.ivory : HomeScreen._muted,
          fontSize: 10,
        ),
      ),
    );
  }
}

class _OfferBanner extends StatelessWidget {
  const _OfferBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class _VenueCard extends StatelessWidget {
  const _VenueCard({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.rating,
  });

  final String title;
  final String subtitle;
  final String image;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(27),
        border: Border.all(color: HomeScreen._line, width: 1.5),
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
                Column(
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
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: HomeScreen._muted,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Icon(
                      Icons.schedule_rounded,
                      size: 13,
                      color: HomeScreen._muted,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Ready in 10–15 min',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: HomeScreen._muted,
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
    );
  }
}
