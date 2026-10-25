import 'package:flutter/material.dart';
import 'package:piko/shared/services/favorite_cafes.dart';
import 'package:piko/customer/restaurant/restaurant_detail_screen.dart';
import 'package:piko/customer/home/widgets/category_chip.dart';
import 'package:piko/customer/home/widgets/offer_card.dart';
import 'package:piko/customer/home/widgets/restaurant_card.dart';
import 'package:piko/shared/theme/app_colors.dart';
import 'package:piko/shared/widgets/piko_bottom_navigation.dart';

import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const _muted = Color(0xFF748076);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ivory,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: [
                  _HomeContent(
                    onExplore: () => setState(() => _currentIndex = 1),
                  ),
                  SearchScreen(onBack: () => setState(() => _currentIndex = 0)),
                ],
              ),
            ),
            PikoBottomNavigation(
              currentIndex: _currentIndex,
              onItemSelected: (index) {
                if (index == 0 || index == 1) {
                  setState(() => _currentIndex = index);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        index == 2
                            ? 'Orders coming soon'
                            : 'Profile coming soon',
                      ),
                    ),
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

class _HomeContent extends StatelessWidget {
  final VoidCallback? onExplore;
  const _HomeContent({this.onExplore});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(32, 12, 32, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _TopBar(),
          const SizedBox(height: 18),
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
                      color: HomeScreen._muted,
                      fontSize: 10,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Location selection coming soon'),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Text(
                          'Gulberg, Lahore',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: AppColors.ink,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 16,
                          color: AppColors.ink,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No new notifications')),
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.notifications_none_rounded,
                  color: AppColors.ink,
                  size: 22,
                ),
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
          OfferCard(
            onTap:
                onExplore ??
                () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const RestaurantDetailScreen(
                      restaurantName: 'June Coffee',
                    ),
                  ),
                ),
          ),
          const SizedBox(height: 24),
          ValueListenableBuilder<Set<String>>(
            valueListenable: FavoriteCafes.names,
            builder: (context, favorites, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SectionHeading('Favorites'),
                const SizedBox(height: 12),
                if (favorites.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.line),
                    ),
                    child: const Text(
                      'Your favorite cafés, all together. Tap the bookmark on a café to save it here.',
                      style: TextStyle(
                        color: HomeScreen._muted,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  )
                else
                  _CafeList(names: favorites.toList()),
                const SizedBox(height: 28),
                const _SectionHeading('Explore more'),
                const SizedBox(height: 12),
                _CafeList(
                  names: [
                    'Mocca',
                    'June Coffee',
                  ].where((name) => !favorites.contains(name)).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 28,
      width: double.infinity,
      child: Center(
        child: Text(
          'Home',
          style: TextStyle(
            fontFamily: 'Inter',
            color: HomeScreen._muted,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _CategoryRow extends StatefulWidget {
  const _CategoryRow();

  @override
  State<_CategoryRow> createState() => _CategoryRowState();
}

class _CategoryRowState extends State<_CategoryRow> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: ['For you', 'Coffee', 'Bakery', 'Lunch'].asMap().entries.map((
          entry,
        ) {
          return CategoryChip(
            entry.value,
            selected: entry.key == _selectedIndex,
            onTap: () => setState(() => _selectedIndex = entry.key),
          );
        }).toList(),
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(
      color: AppColors.ink,
      fontSize: 20,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
    ),
  );
}

class _CafeList extends StatelessWidget {
  const _CafeList({required this.names});
  final List<String> names;

  @override
  Widget build(BuildContext context) {
    if (names.isEmpty) {
      return const Text(
        'You’ve saved all the nearby cafés. More places coming soon.',
        style: TextStyle(color: HomeScreen._muted, fontSize: 13, height: 1.5),
      );
    }
    return SizedBox(
      height: 300,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: names.length,
        separatorBuilder: (_, index) => const SizedBox(width: 18),
        itemBuilder: (context, index) {
          final name = names[index];
          final isMocca = name == 'Mocca';
          return RestaurantCard(
            title: name,
            subtitle: 'Coffee & bakery · ${isMocca ? 6 : 8} min walk',
            image: isMocca
                ? 'assets/images/menu.svg'
                : 'assets/images/cafe_hero.svg',
            rating: isMocca ? '4.9' : '4.8',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => isMocca
                    ? const RestaurantDetailScreen(
                        restaurantName: 'Mocca',
                        tagline: 'Artisanal coffee and fine European pastries.',
                        address: 'Mall 1, Main Boulevard, Gulberg, Lahore',
                        readyTime: '10–15 minutes',
                      )
                    : RestaurantDetailScreen(restaurantName: name),
              ),
            ),
          );
        },
      ),
    );
  }
}
