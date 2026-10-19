import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piko/customer/restaurant/item_detail_screen.dart';
import 'package:piko/shared/theme/app_colors.dart';

class MenuItemData {
  final String title;
  final String description;
  final int price;
  final String category;
  final String image;
  final bool isPopular;

  const MenuItemData({
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
    this.isPopular = false,
  });
}

class MenuScreen extends StatefulWidget {
  final String restaurantName;

  const MenuScreen({super.key, this.restaurantName = 'June Coffee'});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _selectedCategoryIndex = 0;
  int _itemCount = 2;
  int _cartTotal = 1070;

  static const _muted = Color(0xFF748076);
  static const _line = Color(0xFFE1E5DB);

  final List<String> _categories = [
    'Popular',
    'Coffee',
    'Bakery',
    'Cold drinks',
  ];

  final List<MenuItemData> _allItems = const [
    MenuItemData(
      title: 'Honey oat latte',
      description: 'Oat milk · a little sweetness',
      price: 650,
      category: 'Coffee',
      image: 'assets/images/latte_hero.svg',
      isPopular: true,
    ),
    MenuItemData(
      title: 'Butter croissant',
      description: 'Flaky, golden, baked this morning',
      price: 420,
      category: 'Bakery',
      image: 'assets/images/menu.svg',
      isPopular: true,
    ),
    MenuItemData(
      title: 'Iced latte',
      description: 'Smooth, cold, and made to order',
      price: 580,
      category: 'Cold drinks',
      image: 'assets/images/latte_hero.svg',
      isPopular: true,
    ),
    MenuItemData(
      title: 'Cold brew',
      description: 'Steeped 16 hours, bold and crisp',
      price: 550,
      category: 'Cold drinks',
      image: 'assets/images/menu.svg',
      isPopular: false,
    ),
    MenuItemData(
      title: 'Pain au chocolat',
      description: 'Dark Belgian chocolate in flaky pastry',
      price: 480,
      category: 'Bakery',
      image: 'assets/images/menu.svg',
      isPopular: false,
    ),
    MenuItemData(
      title: 'Classic Flat White',
      description: 'Double ristretto with micro-foamed milk',
      price: 540,
      category: 'Coffee',
      image: 'assets/images/latte_hero.svg',
      isPopular: false,
    ),
  ];

  List<MenuItemData> get _filteredItems {
    final selectedCategory = _categories[_selectedCategoryIndex];
    if (selectedCategory == 'Popular') {
      return _allItems.where((item) => item.isPopular).toList();
    }
    return _allItems
        .where((item) =>
            item.category.toLowerCase() == selectedCategory.toLowerCase())
        .toList();
  }

  Future<void> _openCustomize(MenuItemData item) async {
    final added = await Navigator.of(context).push<int>(
      MaterialPageRoute(
        builder: (_) => ItemDetailScreen(
          title: item.title,
          description: item.description,
          basePrice: item.price,
          heroSvg: item.image,
        ),
      ),
    );
    if (added != null && added > 0 && mounted) {
      setState(() {
        _itemCount += added;
        _cartTotal += item.price * added;
      });
    }
  }

  void _showCartSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
        decoration: const BoxDecoration(
          color: AppColors.ivory,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFDCD8CF),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your cart · $_itemCount items',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.ink,
                  ),
                ),
                Text(
                  'Rs. $_cartTotal',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.forest,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Text(
              'June Coffee • Gulberg, Lahore',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                color: _muted,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Proceeding to pickup schedule...'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.forest,
                  foregroundColor: AppColors.ivory,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Choose pickup time',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: AppColors.lime,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
                    content: Text('Search & menu options'),
                  ),
                ),
              ),
              const SizedBox(height: 36),
              Text(
                widget.restaurantName,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.ink,
                  fontSize: 29,
                  height: 1.02,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.1,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Freshly made. Yours to pick up.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: _muted,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 24),

              // Category Selector Row
              SizedBox(
                height: 38,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedCategoryIndex == index;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCategoryIndex = index),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.forest : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? AppColors.forest : _line,
                            width: 1.2,
                          ),
                        ),
                        child: Text(
                          _categories[index],
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: isSelected ? AppColors.ivory : _muted,
                            fontSize: 11,
                            fontWeight:
                                isSelected ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Menu Hero Banner
              Container(
                width: double.infinity,
                height: 140,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8DFD0),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: _line, width: 1.2),
                ),
                child: SvgPicture.asset(
                  'assets/images/menu_banner.svg',
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 24),

              // Section Heading
              const Text(
                'The usual favorites',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.ink,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.4,
                ),
              ),

              const SizedBox(height: 18),

              // Filtered Menu Items
              ..._filteredItems.map((item) {
                return Column(
                  children: [
                    _MenuItemTile(
                      item: item,
                      onTap: () => _openCustomize(item),
                      onAdd: () => _openCustomize(item),
                    ),
                    const _Divider(),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 8, 28, 14),
          child: GestureDetector(
            onTap: _showCartSheet,
            behavior: HitTestBehavior.opaque,
            child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 22),
              decoration: BoxDecoration(
                color: AppColors.forest,
                borderRadius: BorderRadius.circular(28),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33173E35),
                    blurRadius: 16,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'View cart · $_itemCount items',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      color: AppColors.ivory,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Rs. $_cartTotal',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          color: AppColors.lime,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: AppColors.lime,
                        size: 18,
                      ),
                    ],
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
      height: 28,
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 16,
              color: Color(0xFF748076),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Menu',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: Color(0xFF748076),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
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
              color: Color(0xFF748076),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItemTile extends StatelessWidget {
  const _MenuItemTile({
    required this.item,
    required this.onTap,
    required this.onAdd,
  });

  final MenuItemData item;
  final VoidCallback onTap;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 92,
                height: 100,
                color: const Color(0xFFEDE9DE),
                child: SvgPicture.asset(
                  item.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      color: AppColors.ink,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      color: Color(0xFF748076),
                      fontSize: 11.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rs. ${item.price}',
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
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE1E5DB), width: 1.2),
                ),
                child: const Icon(
                  Icons.add_rounded,
                  size: 20,
                  color: AppColors.ink,
                ),
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
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Divider(height: 1, thickness: 1, color: Color(0xFFE1E5DB)),
    );
  }
}
