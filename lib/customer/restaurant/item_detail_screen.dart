import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piko/customer/cart/widgets/cart_item_tile.dart';
import 'package:piko/shared/theme/app_colors.dart';

class CustomizedItemResult {
  final String title;
  final String size;
  final String milk;
  final List<String> addons;
  final String sweetness;
  final String note;
  final int unitPrice;
  final int quantity;
  final int totalPrice;
  final String heroSvg;

  const CustomizedItemResult({
    required this.title,
    required this.size,
    required this.milk,
    required this.addons,
    required this.sweetness,
    required this.note,
    required this.unitPrice,
    required this.quantity,
    required this.totalPrice,
    required this.heroSvg,
  });

  CartItemModel toCartItem() {
    final details = <String>[];
    if (size != 'Regular') details.add(size);
    details.add(milk);
    if (addons.isNotEmpty) details.addAll(addons);
    if (!sweetness.toLowerCase().contains('standard')) details.add(sweetness);
    if (note.isNotEmpty) details.add('Note: "$note"');

    final subtitle = details.isNotEmpty
        ? details.join(' • ')
        : 'Standard customization';

    return CartItemModel(
      id: '${title.toLowerCase().replaceAll(' ', '_')}_${DateTime.now().microsecondsSinceEpoch}',
      title: title,
      subtitle: subtitle,
      unitPrice: unitPrice,
      quantity: quantity,
      thumbnail: SvgPicture.asset(
        heroSvg,
        fit: BoxFit.cover,
        placeholderBuilder: (_) => const Icon(
          Icons.local_cafe_rounded,
          color: AppColors.forest,
          size: 24,
        ),
      ),
    );
  }
}

class ItemDetailScreen extends StatefulWidget {
  final String title;
  final String description;
  final int basePrice;
  final String heroSvg;
  final String badgeText;

  const ItemDetailScreen({
    super.key,
    this.title = 'Honey oat latte',
    this.description = 'Espresso, creamy oat milk, and a touch of honey.',
    this.basePrice = 650,
    this.heroSvg = 'assets/images/latte_hero.svg',
    this.badgeText = 'Bestseller',
  });

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  // Customization state
  int _selectedSizeIndex = 0; // 0: Regular, 1: Large (+150)
  int _selectedMilkIndex = 0; // 0: Oat milk (+0), 1: Almond milk (+80), 2: Whole milk (+0)
  final Set<int> _selectedAddons = {}; // indices of chosen addons
  int _sweetnessIndex = 0; // 0: Standard, 1: Less sweet, 2: Extra sweet
  int _quantity = 1;
  final TextEditingController _noteController = TextEditingController();

  final List<Map<String, dynamic>> _sizes = [
    {'name': 'Regular', 'price': 0},
    {'name': 'Large', 'price': 150},
  ];

  final List<Map<String, dynamic>> _milks = [
    {'name': 'Oat milk', 'subtitle': 'Included', 'price': 0},
    {'name': 'Almond milk', 'subtitle': '+ Rs. 80', 'price': 80},
    {'name': 'Whole milk', 'subtitle': 'Included', 'price': 0},
  ];

  final List<Map<String, dynamic>> _addons = [
    {'name': 'Extra espresso shot', 'price': 120},
    {'name': 'Vanilla syrup', 'price': 60},
    {'name': 'Caramel drizzle', 'price': 50},
  ];

  final List<String> _sweetnessLevels = [
    'Standard (touch of honey)',
    'Less sweet',
    'No added sweet',
  ];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  int get _unitPrice {
    var price = widget.basePrice;
    price += (_sizes[_selectedSizeIndex]['price'] as int);
    price += (_milks[_selectedMilkIndex]['price'] as int);
    for (final index in _selectedAddons) {
      price += (_addons[index]['price'] as int);
    }
    return price;
  }

  int get _totalPrice => _unitPrice * _quantity;

  void _onAddToCart() {
    final result = CustomizedItemResult(
      title: widget.title,
      size: _sizes[_selectedSizeIndex]['name'] as String,
      milk: _milks[_selectedMilkIndex]['name'] as String,
      addons: _selectedAddons.map((i) => _addons[i]['name'] as String).toList(),
      sweetness: _sweetnessLevels[_sweetnessIndex],
      note: _noteController.text.trim(),
      unitPrice: _unitPrice,
      quantity: _quantity,
      totalPrice: _totalPrice,
      heroSvg: widget.heroSvg,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$_quantity× ${widget.title} added to cart · Rs. $_totalPrice',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
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

              // Hero Image Card
              _buildHeroBanner(),

              const SizedBox(height: 20),

              // Title
              Text(
                widget.title,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.ink,
                  fontSize: 29,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.0,
                  height: 1.1,
                ),
              ),

              const SizedBox(height: 8),

              // Description
              Text(
                widget.description,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.subtext,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 14),

              // Price & Bestseller badge row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Rs. ${widget.basePrice}',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      color: AppColors.ink,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.chipBg,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      widget.badgeText,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        color: AppColors.forest,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(color: AppColors.line, thickness: 1),
              ),

              // Section: Choose a size (Required)
              _buildSectionHeader(title: 'Choose a size', badge: 'Required'),
              const SizedBox(height: 12),
              _buildSizeOptions(),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(color: AppColors.line, thickness: 1),
              ),

              // Section: Milk choice
              _buildSectionHeader(title: 'Milk choice', badge: 'Included'),
              const SizedBox(height: 12),
              _buildMilkOptions(),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(color: AppColors.line, thickness: 1),
              ),

              // Section: Make it yours (Addons)
              _buildSectionHeader(title: 'Make it yours', badge: 'Optional'),
              const SizedBox(height: 12),
              _buildAddonOptions(),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(color: AppColors.line, thickness: 1),
              ),

              // Section: Sweetness level
              _buildSectionHeader(title: 'Sweetness', badge: 'Custom'),
              const SizedBox(height: 12),
              _buildSweetnessOptions(),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(color: AppColors.line, thickness: 1),
              ),

              // Section: Special instructions
              const Text(
                'Note for barista',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.ink,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.line),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _noteController,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    color: AppColors.ink,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'e.g. Extra hot, less ice, or on the side',
                    hintStyle: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      color: Color(0xFF9AA198),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomActionBar(context),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return SizedBox(
      height: 28,
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
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
                'Customize item',
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

  Widget _buildHeroBanner() {
    return Container(
      width: double.infinity,
      height: 175,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFFE8DFD0),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.line, width: 1.2),
      ),
      child: SvgPicture.asset(
        widget.heroSvg,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildSectionHeader({required String title, required String badge}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Inter',
            color: AppColors.ink,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            color: const Color(0xFFECEFE8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            badge,
            style: const TextStyle(
              fontFamily: 'Inter',
              color: AppColors.muted,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSizeOptions() {
    return Row(
      children: List.generate(_sizes.length, (index) {
        final isSelected = _selectedSizeIndex == index;
        final size = _sizes[index];
        final priceOffset = size['price'] as int;
        final label =
            priceOffset > 0 ? '${size['name']} + Rs. $priceOffset' : size['name'] as String;

        return GestureDetector(
          onTap: () => setState(() => _selectedSizeIndex = index),
          behavior: HitTestBehavior.opaque,
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.forest : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? AppColors.forest : AppColors.line,
                width: 1.2,
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                color: isSelected ? AppColors.ivory : AppColors.ink,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildMilkOptions() {
    return Column(
      children: List.generate(_milks.length, (index) {
        final isSelected = _selectedMilkIndex == index;
        final milk = _milks[index];
        return GestureDetector(
          onTap: () => setState(() => _selectedMilkIndex = index),
          behavior: HitTestBehavior.opaque,
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFF2F6ED) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? AppColors.forest : AppColors.line,
                width: isSelected ? 1.4 : 1.0,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      isSelected
                          ? Icons.radio_button_checked_rounded
                          : Icons.radio_button_off_rounded,
                      size: 20,
                      color: isSelected ? AppColors.forest : AppColors.muted,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      milk['name'] as String,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        color: AppColors.ink,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Text(
                  milk['subtitle'] as String,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: isSelected ? AppColors.forest : AppColors.muted,
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildAddonOptions() {
    return Column(
      children: List.generate(_addons.length, (index) {
        final isSelected = _selectedAddons.contains(index);
        final addon = _addons[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                _selectedAddons.remove(index);
              } else {
                _selectedAddons.add(index);
              }
            });
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFF2F6ED) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? AppColors.forest : AppColors.line,
                width: isSelected ? 1.4 : 1.0,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      isSelected
                          ? Icons.check_box_rounded
                          : Icons.check_box_outline_blank_rounded,
                      size: 20,
                      color: isSelected ? AppColors.forest : AppColors.muted,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      addon['name'] as String,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        color: AppColors.ink,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Text(
                  '+ Rs. ${addon['price']}',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: isSelected ? AppColors.forest : AppColors.muted,
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSweetnessOptions() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(_sweetnessLevels.length, (index) {
        final isSelected = _sweetnessIndex == index;
        return GestureDetector(
          onTap: () => setState(() => _sweetnessIndex = index),
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.forest : Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isSelected ? AppColors.forest : AppColors.line,
              ),
            ),
            child: Text(
              _sweetnessLevels[index],
              style: TextStyle(
                fontFamily: 'Inter',
                color: isSelected ? AppColors.ivory : AppColors.ink,
                fontSize: 11.5,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBottomActionBar(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(28, 10, 28, 14),
        decoration: const BoxDecoration(
          color: AppColors.ivory,
          border: Border(top: BorderSide(color: AppColors.line)),
        ),
        child: Row(
          children: [
            // Quantity Selector
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.line, width: 1.2),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (_quantity > 1) {
                        setState(() => _quantity--);
                      }
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 28),
                    icon: Icon(
                      Icons.remove_rounded,
                      size: 18,
                      color: _quantity > 1 ? AppColors.ink : AppColors.muted,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '$_quantity',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() => _quantity++),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 28),
                    icon: const Icon(
                      Icons.add_rounded,
                      size: 18,
                      color: AppColors.ink,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 14),

            // Add to Cart Button
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _onAddToCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.forest,
                    foregroundColor: AppColors.ivory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Add',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        '•',
                        style: TextStyle(color: AppColors.lime, fontSize: 14),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Rs. $_totalPrice',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.lime,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
