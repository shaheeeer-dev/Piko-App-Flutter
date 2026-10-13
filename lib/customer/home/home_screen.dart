import 'package:flutter/material.dart';
import 'package:piko/customer/restaurant/menu_screen.dart';
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
                  const _HomeContent(),
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
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Order ahead selected')),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: ListView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              children: [
                RestaurantCard(
                  title: 'Mocca',
                  subtitle: 'Coffee & bakery · 6 min walk',
                  image: 'assets/images/menu.svg',
                  rating: '4.9',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const MenuScreen(restaurantName: 'Mocca'),
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                RestaurantCard(
                  title: 'June Coffee',
                  subtitle: 'Coffee & bakery · 8 min walk',
                  image: 'assets/images/menu.svg',
                  rating: '4.8',
                  onTap: () => Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => const MenuScreen())),
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
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
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
