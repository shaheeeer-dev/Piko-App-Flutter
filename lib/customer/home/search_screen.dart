import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piko/customer/restaurant/restaurant_detail_screen.dart';
import 'package:piko/shared/theme/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, this.onBack});

  final VoidCallback? onBack;
  static const _muted = Color(0xFF748076);
  static const _line = Color(0xFFE1E5DB);
  static const _field = Color(0xFFF0F1EB);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var _query = '';
  var _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(32, 12, 32, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TopBar(
            onBack: widget.onBack,
            onMore: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('More discovery options coming soon'),
              ),
            ),
          ),
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
          _SearchField(onChanged: (value) => setState(() => _query = value)),
          const SizedBox(height: 17),
          _FilterRow(
            selectedIndex: _selectedFilter,
            onSelected: (index) => setState(() => _selectedFilter = index),
          ),
          const SizedBox(height: 21),
          const Text(
            '12 places to make your day',
            style: TextStyle(
              fontFamily: 'Inter',
              color: SearchScreen._muted,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 22),
          if (_query.isEmpty || 'june coffee'.contains(_query.toLowerCase()))
            _SearchVenueCard(
              title: 'June Coffee',
              image: 'assets/images/cafe_hero.svg',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const RestaurantDetailScreen(
                    restaurantName: 'June Coffee',
                  ),
                ),
              ),
            ),
          if (_query.isEmpty || 'mocca'.contains(_query.toLowerCase())) ...[
            const SizedBox(height: 16),
            _SearchVenueCard(
              title: 'Mocca',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const RestaurantDetailScreen(
                    restaurantName: 'Mocca',
                    tagline: 'Artisanal coffee and fine European pastries.',
                    address: 'Mall 1, Main Boulevard, Gulberg, Lahore',
                    readyTime: '10–15 minutes',
                  ),
                ),
              ),
            ),
          ],
          if (_query.isNotEmpty &&
              !'june coffee'.contains(_query.toLowerCase()) &&
              !'mocca'.contains(_query.toLowerCase()))
            const Padding(
              padding: EdgeInsets.only(top: 24),
              child: Text(
                'No places found',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: SearchScreen._muted,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onBack, required this.onMore});

  final VoidCallback? onBack;
  final VoidCallback onMore;

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
          IconButton(
            onPressed: onMore,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(
              Icons.more_vert,
              size: 18,
              color: SearchScreen._muted,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      style: const TextStyle(
        fontFamily: 'Inter',
        color: AppColors.ink,
        fontSize: 11,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: SearchScreen._field,
        hintText: 'Coffee near me',
        hintStyle: const TextStyle(
          fontFamily: 'Inter',
          color: Color(0xFF9AA198),
          fontSize: 11,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          size: 22,
          color: SearchScreen._muted,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(19),
          borderSide: const BorderSide(color: SearchScreen._line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(19),
          borderSide: const BorderSide(color: SearchScreen._line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(19),
          borderSide: const BorderSide(color: AppColors.forest),
        ),
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  const _FilterRow({required this.selectedIndex, required this.onSelected});

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: Row(
        children: [
          _FilterChip(
            'Nearby',
            selected: selectedIndex == 0,
            onTap: () => onSelected(0),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            'Top rated',
            selected: selectedIndex == 1,
            onTap: () => onSelected(1),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            'Open now',
            selected: selectedIndex == 2,
            onTap: () => onSelected(2),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip(this.label, {required this.onTap, this.selected = false});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}

class _SearchVenueCard extends StatelessWidget {
  const _SearchVenueCard({
    required this.title,
    required this.onTap,
    this.image = 'assets/images/menu.svg',
  });

  final String title;
  final VoidCallback onTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
              child: SvgPicture.asset(
                image,
                fit: BoxFit.cover,
              ),
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
                      Icon(
                        Icons.schedule_rounded,
                        size: 13,
                        color: SearchScreen._muted,
                      ),
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
                      Icon(
                        Icons.location_on_outlined,
                        size: 13,
                        color: SearchScreen._muted,
                      ),
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
      ),
    );
  }
}
