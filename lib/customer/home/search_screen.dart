import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piko/shared/theme/app_colors.dart';
import 'package:piko/shared/widgets/piko_bottom_navigation.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  static const _muted = Color(0xFF748076);
  static const _line = Color(0xFFE1E5DB);
  static const _field = Color(0xFFF0F1EB);

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
                    _TopBar(onBack: () => Navigator.of(context).pop()),
                    const SizedBox(height: 43),
                    const Text(
                      'Find your next\nfavorite.',
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
                    const _SearchField(),
                    const SizedBox(height: 17),
                    const _FilterRow(),
                    const SizedBox(height: 21),
                    const Text(
                      '12 places to make your day',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: _muted,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 22),
                    const _SearchVenueCard(title: 'June Coffee'),
                    const SizedBox(height: 16),
                    const _SearchVenueCard(title: 'Mocca'),
                  ],
                ),
              ),
            ),
            PikoBottomNavigation(
              currentIndex: 1,
              onItemSelected: (index) {
                if (index == 0) {
                  Navigator.of(context).pop();
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
  const _TopBar({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26,
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 16,
              color: SearchScreen._muted,
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Search & discovery',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: SearchScreen._muted,
                  fontSize: 11,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
            child: Icon(Icons.more_vert, size: 18, color: SearchScreen._muted),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: SearchScreen._field,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: SearchScreen._line),
      ),
      child: const Row(
        children: [
          SizedBox(width: 17),
          Icon(Icons.search_rounded, size: 22, color: SearchScreen._muted),
          SizedBox(width: 12),
          Text(
            'Coffee near me',
            style: TextStyle(
              fontFamily: 'Inter',
              color: Color(0xFF9AA198),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  const _FilterRow();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: Row(
        children: const [
          _FilterChip('Nearby', selected: true),
          SizedBox(width: 8),
          _FilterChip('Top rated'),
          SizedBox(width: 8),
          _FilterChip('Open now'),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip(this.label, {this.selected = false});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? AppColors.forest : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: selected ? null : Border.all(color: SearchScreen._line),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Inter',
          color: selected ? AppColors.ivory : SearchScreen._muted,
          fontSize: 10,
        ),
      ),
    );
  }
}

class _SearchVenueCard extends StatelessWidget {
  const _SearchVenueCard({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(27),
        border: Border.all(color: SearchScreen._line, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 138,
            width: double.infinity,
            child: SvgPicture.asset('assets/images/menu.svg', fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 13, 14, 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9F0DC),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Text(
                        '★ 4.9',
                        style: TextStyle(
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
                const Text(
                  'Coffee & bakery · 8 min walk',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: SearchScreen._muted,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Icon(Icons.schedule_rounded,
                        size: 13, color: SearchScreen._muted),
                    SizedBox(width: 5),
                    Text(
                      'Ready in 10–15 min',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: SearchScreen._muted,
                        fontSize: 9,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text('•', style: TextStyle(color: SearchScreen._muted)),
                    SizedBox(width: 8),
                    Icon(Icons.location_on_outlined,
                        size: 13, color: SearchScreen._muted),
                    SizedBox(width: 3),
                    Text(
                      '0.4 km',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        color: SearchScreen._muted,
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

