import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piko/customer/restaurant/item_detail_screen.dart';
import 'package:piko/shared/theme/app_colors.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key, this.restaurantName = 'June Coffee'});

  final String restaurantName;

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  var _itemCount = 2;

  static const _muted = Color(0xFF748076);
  static const _line = Color(0xFFE1E5DB);

  Future<void> _openCustomize({
    required String title,
    required String description,
    required int basePrice,
    String heroSvg = 'assets/images/latte_hero.svg',
  }) async {
    final added = await Navigator.of(context).push<int>(
      MaterialPageRoute(
        builder: (_) => ItemDetailScreen(
          title: title,
          description: description,
          basePrice: basePrice,
          heroSvg: heroSvg,
        ),
      ),
    );
    if (added != null && added > 0 && mounted) {
      setState(() => _itemCount += added);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ivory,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(32, 12, 32, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopBar(
                onBack: () => Navigator.of(context).pop(),
                onMore: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('More menu options coming soon'),
                  ),
                ),
              ),
              const SizedBox(height: 39),
              Text(
                widget.restaurantName,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.ink,
                  fontSize: 29,
                  height: 1.02,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1.1,
                ),
              ),
              const SizedBox(height: 17),
              const Text(
                'Freshly made. Yours to pick up.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: _muted,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 27),
              const _CategoryRow(),
              const SizedBox(height: 24),
              ClipRRect(
                borderRadius: BorderRadius.circular(27),
                child: SizedBox(
                  width: double.infinity,
                  height: 214,
                  child: SvgPicture.asset(
                    'assets/images/menu.svg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 27),
              const Text(
                'The usual favorites',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.ink,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 22),
              _MenuItem(
                title: 'Honey oat latte',
                description: 'Oat milk · a little sweetness',
                price: 'Rs. 650',
                image: 'assets/images/latte_hero.svg',
                onAdd: () => _openCustomize(
                  title: 'Honey oat latte',
                  description:
                      'Espresso, creamy oat milk, and a touch of honey.',
                  basePrice: 650,
                  heroSvg: 'assets/images/latte_hero.svg',
                ),
                onTap: () => _openCustomize(
                  title: 'Honey oat latte',
                  description:
                      'Espresso, creamy oat milk, and a touch of honey.',
                  basePrice: 650,
                  heroSvg: 'assets/images/latte_hero.svg',
                ),
              ),
              const _Divider(),
              _MenuItem(
                title: 'Butter croissant',
                description: 'Flaky, golden, baked this morning',
                price: 'Rs. 420',
                onAdd: () => _openCustomize(
                  title: 'Butter croissant',
                  description: 'Flaky, golden, baked fresh this morning.',
                  basePrice: 420,
                  heroSvg: 'assets/images/menu.svg',
                ),
                onTap: () => _openCustomize(
                  title: 'Butter croissant',
                  description: 'Flaky, golden, baked fresh this morning.',
                  basePrice: 420,
                  heroSvg: 'assets/images/menu.svg',
                ),
              ),
              const _Divider(),
              _MenuItem(
                title: 'Iced latte',
                description: 'Smooth, cold, and made to order',
                price: 'Rs. 580',
                onAdd: () => _openCustomize(
                  title: 'Iced latte',
                  description:
                      'Smooth, cold espresso with fresh milk over ice.',
                  basePrice: 580,
                  heroSvg: 'assets/images/latte_hero.svg',
                ),
                onTap: () => _openCustomize(
                  title: 'Iced latte',
                  description:
                      'Smooth, cold espresso with fresh milk over ice.',
                  basePrice: 580,
                  heroSvg: 'assets/images/latte_hero.svg',
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 10, 32, 10),
          child: GestureDetector(
            onTap: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Your cart'),
                content: Text('$_itemCount items ready for checkout.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
            child: Container(
              height: 64,
              padding: const EdgeInsets.symmetric(horizontal: 22),
              decoration: BoxDecoration(
                color: AppColors.forest,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'View cart · $_itemCount items',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      color: AppColors.ivory,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                    'Rs. 1,070',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: AppColors.ivory,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onBack, required this.onMore});

  final VoidCallback onBack;
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
              color: _MenuScreenState._muted,
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Menu',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: _MenuScreenState._muted,
                  fontSize: 14,
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
              color: _MenuScreenState._muted,
            ),
          ),
        ],
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
      height: 46,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: ['Popular', 'Coffee', 'Bakery', 'Cold drinks']
            .asMap()
            .entries
            .map(
              (entry) => _CategoryChip(
                entry.value,
                selected: entry.key == _selectedIndex,
                onTap: () => setState(() => _selectedIndex = entry.key),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip(this.label, {required this.onTap, this.selected = false});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 17),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.forest : Colors.transparent,
          borderRadius: BorderRadius.circular(22),
          border: selected
              ? null
              : Border.all(color: _MenuScreenState._line, width: 1.5),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            color: selected ? AppColors.ivory : _MenuScreenState._muted,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.title,
    required this.description,
    required this.price,
    required this.onAdd,
    this.onTap,
    this.image = 'assets/images/menu.svg',
  });

  final String title;
  final String description;
  final String price;
  final VoidCallback onAdd;
  final VoidCallback? onTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? onAdd,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 103,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: SizedBox(
                width: 96,
                height: 103,
                child: SvgPicture.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                Text(
                  description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: _MenuScreenState._muted,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 9),
                Text(
                  price,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: AppColors.ink,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onAdd,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 35,
              height: 35,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: _MenuScreenState._line, width: 1.5),
              ),
              child: const Icon(Icons.add, size: 19, color: AppColors.ink),
            ),
          ),
        ],
      ),
    ),
  );
}
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 18),
      child: Divider(height: 1, thickness: 1.5, color: _MenuScreenState._line),
    );
  }
}
