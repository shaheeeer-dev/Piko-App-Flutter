import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piko/shared/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _muted = Color(0xFF748076);
  static const _line = Color(0xFFE1E5DB);
  static const _sand = Color(0xFFE9DFC9);

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
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _TopBar(),
                    const SizedBox(height: 34),
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
                                fontSize: 12,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Text(
                                  'Gulberg, Lahore',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: AppColors.ink,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Icon(Icons.keyboard_arrow_down_rounded,
                                    size: 20, color: AppColors.ink),
                              ],
                            ),
                          ],
                        ),
                        const Icon(Icons.notifications_none_rounded,
                            color: AppColors.ink, size: 29),
                      ],
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      'A good day starts\nwith something good.',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: AppColors.ink,
                        fontSize: 36,
                        height: 1.16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -1.8,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const _CategoryRow(),
                    const SizedBox(height: 24),
                    const _OfferBanner(),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 370,
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
            const _BottomNavigation(),
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
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 21, color: HomeScreen._muted),
        ),
        const Expanded(
          child: Center(
            child: Text('Home',
                style: TextStyle(
                    fontFamily: 'Inter', color: HomeScreen._muted, fontSize: 17)),
          ),
        ),
        const SizedBox(width: 21),
      ],
    );
  }
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
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
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 23),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? AppColors.forest : Colors.transparent,
        borderRadius: BorderRadius.circular(32),
        border: selected ? null : Border.all(color: HomeScreen._line, width: 2),
      ),
      child: Text(label,
          style: TextStyle(
              fontFamily: 'Inter',
              color: selected ? AppColors.ivory : HomeScreen._muted,
              fontSize: 16)),
    );
  }
}

class _OfferBanner extends StatelessWidget {
  const _OfferBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(30, 25, 24, 24),
      decoration: BoxDecoration(
        color: AppColors.forest,
        borderRadius: BorderRadius.circular(55),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('YOUR MORNING, UPGRADED',
              style: TextStyle(
                  fontFamily: 'Inter',
                  color: Color(0xFFD7E7A1),
                  fontSize: 12,
                  letterSpacing: 2)),
            SizedBox(height: 16),
          Text('Less queue.\nMore you.',
              style: TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.ivory,
                  fontSize: 36,
                  height: 1.18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1.5)),
          SizedBox(height: 18),
          Text('Order ahead with Piko ↗',
              style: TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.lime,
                  fontSize: 15,
                  fontWeight: FontWeight.w500)),
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
        borderRadius: BorderRadius.circular(38),
        border: Border.all(color: HomeScreen._line, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 180,
            width: double.infinity,
            child: SvgPicture.asset(image, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 18, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            color: AppColors.ink,
                            fontSize: 19,
                            fontWeight: FontWeight.w700)),
                    const SizedBox(height: 9),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 7),
                      decoration: BoxDecoration(
                          color: const Color(0xFFE9F0DC),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text('★ $rating',
                          style: const TextStyle(
                              fontFamily: 'Inter',
                              color: AppColors.forest,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                const SizedBox(height: 9),
                Text(subtitle,
                    style: const TextStyle(
                        fontFamily: 'Inter', color: HomeScreen._muted, fontSize: 14)),
                const SizedBox(height: 14),
                const Row(
                  children: [
                    Icon(Icons.schedule_rounded, size: 18, color: HomeScreen._muted),
                    SizedBox(width: 6),
                    Text('Ready in 10–15 min',
                        style: TextStyle(
                            fontFamily: 'Inter', color: HomeScreen._muted, fontSize: 12)),
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

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 106,
      padding: const EdgeInsets.fromLTRB(20, 7, 20, 12),
      decoration: const BoxDecoration(
        color: AppColors.ivory,
        border: Border(top: BorderSide(color: HomeScreen._line, width: 1.5)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(Icons.home_outlined, 'Home', selected: true),
          _NavItem(Icons.search_rounded, 'Explore'),
          _NavItem(Icons.receipt_long_outlined, 'Orders'),
          _NavItem(Icons.person_outline_rounded, 'Profile'),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem(this.icon, this.label, {this.selected = false});

  final IconData icon;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.forest : const Color(0xFF8B958A);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 55,
          height: 55,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: selected ? AppColors.lime : Colors.transparent,
              shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 29),
        ),
        const SizedBox(height: 3),
        Text(label,
            style: TextStyle(
                fontFamily: 'Inter',
                color: color,
                fontSize: 12,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w400)),
      ],
    );
  }
}
