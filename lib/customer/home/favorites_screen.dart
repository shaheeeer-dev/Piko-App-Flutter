import 'package:flutter/material.dart';
import 'package:piko/customer/restaurant/restaurant_detail_screen.dart';
import 'package:piko/shared/services/favorite_cafes.dart';
import 'package:piko/shared/theme/app_colors.dart';

class FavoritesScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const FavoritesScreen({super.key, this.onBack});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final List<Map<String, dynamic>> _allCafes = [
    {
      'title': 'June Coffee',
      'category': 'Coffee & bakery • 8 min walk',
      'rating': 4.9,
      'timing': 'Ready in 10-15 min • 0.4 km',
      'location': 'Gulberg',
    },
    {
      'title': 'Daily Knead',
      'category': 'Artisan bakery • 12 min walk',
      'rating': 4.9,
      'timing': 'Ready in 10-15 min • 0.4 km',
      'location': 'Gulberg',
    },
    {
      'title': 'Mocca',
      'category': 'Specialty coffee • 15 min walk',
      'rating': 4.8,
      'timing': 'Ready in 5-10 min • 0.9 km',
      'location': 'Mall One, Gulberg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<String>>(
      valueListenable: FavoriteCafes.names,
      builder: (context, favorites, _) {
        final savedCafes = _allCafes.where((c) {
          final title = c['title'] as String;
          // If FavoriteCafes has items, filter by it; otherwise show default list
          return favorites.isEmpty || favorites.contains(title);
        }).toList();

        return Scaffold(
          backgroundColor: AppColors.ivory,
          body: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(28, 12, 28, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Bar
                  _buildTopBar(context),

                  const SizedBox(height: 18),

                  // Headline: "The good list." (Figma Article-16)
                  const Text(
                    'The good list.',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink,
                      letterSpacing: -1.0,
                      height: 1.15,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Your saved places, all together.',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13.5,
                      fontWeight: FontWeight.w400,
                      color: AppColors.subtext,
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Saved Cafes List
                  if (savedCafes.isEmpty)
                    _buildEmptyState()
                  else
                    ...savedCafes.map((cafe) => _buildCafeCard(cafe, favorites)),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return SizedBox(
      height: 28,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (widget.onBack != null) {
                widget.onBack!();
              } else {
                Navigator.of(context).maybePop();
              }
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 16,
              color: AppColors.muted,
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Favorites',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.muted,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _buildCafeCard(Map<String, dynamic> cafe, Set<String> favorites) {
    final title = cafe['title'] as String;
    final category = cafe['category'] as String;
    final rating = cafe['rating'] as double;
    final timing = cafe['timing'] as String;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFEFA),
        borderRadius: BorderRadius.circular(16.5),
        border: Border.all(color: const Color(0xFFE5E7DE), width: 1.2),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RestaurantDetailScreen(
                restaurantName: title,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16.5),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top line: Name + Rating + Bookmark
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDF1E7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 13,
                              color: AppColors.forest,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              rating.toStringAsFixed(1),
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                color: AppColors.forest,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          FavoriteCafes.toggle(title);
                        },
                        child: const Icon(
                          Icons.bookmark_rounded,
                          size: 20,
                          color: AppColors.forest,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 6),

              // Category & Walk time
              Text(
                category,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subtext,
                ),
              ),

              const SizedBox(height: 8),

              // Timing & Distance
              Row(
                children: [
                  const Icon(
                    Icons.access_time_rounded,
                    size: 13,
                    color: AppColors.muted,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    timing,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.subtext,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.center,
      child: const Column(
        children: [
          Icon(
            Icons.bookmark_outline_rounded,
            size: 48,
            color: AppColors.muted,
          ),
          SizedBox(height: 12),
          Text(
            'No favorites saved yet',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Tap the bookmark icon on any café to save it here.',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              color: AppColors.subtext,
            ),
          ),
        ],
      ),
    );
  }
}

