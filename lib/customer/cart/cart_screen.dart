import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piko/customer/cart/widgets/cart_item_tile.dart';
import 'package:piko/customer/cart/widgets/order_summary.dart';
import 'package:piko/shared/theme/app_colors.dart';
import 'package:piko/shared/widgets/piko_button.dart';

class CartScreen extends StatefulWidget {
  final String restaurantName;
  final String location;
  final List<CartItemModel>? initialItems;

  const CartScreen({
    super.key,
    this.restaurantName = 'June Coffee',
    this.location = 'Gulberg',
    this.initialItems,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<CartItemModel> _items;
  static const int _serviceFee = 50;

  @override
  void initState() {
    super.initState();
    _items = widget.initialItems ??
        [
          CartItemModel(
            id: 'honey_oat_latte',
            title: 'Honey oat latte',
            subtitle: 'Oat milk • a little sweetness',
            unitPrice: 650,
            quantity: 1,
            thumbnail: SvgPicture.asset(
              'assets/images/latte_hero.svg',
              fit: BoxFit.cover,
              placeholderBuilder: (_) => const Icon(
                Icons.local_cafe_rounded,
                color: AppColors.forest,
                size: 24,
              ),
            ),
          ),
          CartItemModel(
            id: 'butter_croissant',
            title: 'Butter croissant',
            subtitle: '1 item • Freshly baked',
            unitPrice: 420,
            quantity: 1,
            thumbnail: Container(
              color: const Color(0xFFF7EEDD),
              alignment: Alignment.center,
              child: const Icon(
                Icons.bakery_dining_rounded,
                color: Color(0xFF9F6934),
                size: 26,
              ),
            ),
          ),
        ];
  }

  int get _subtotal =>
      _items.fold<int>(0, (sum, item) => sum + item.totalPrice);

  int get _totalItems =>
      _items.fold<int>(0, (sum, item) => sum + item.quantity);

  void _increment(int index) {
    setState(() {
      _items[index].quantity++;
    });
  }

  void _decrement(int index) {
    setState(() {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
    });
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

              const SizedBox(height: 22),

              // Title & Store location
              const Text(
                'Your little pick-me-up',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                  letterSpacing: -1.0,
                  height: 1.1,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                '${widget.restaurantName} • ${widget.location}',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.subtext,
                ),
              ),

              const SizedBox(height: 24),

              // Cart Items List
              if (_items.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const Icon(
                        Icons.shopping_bag_outlined,
                        size: 44,
                        color: AppColors.muted,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Your cart is empty',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.ink,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Explore menu'),
                      ),
                    ],
                  ),
                )
              else ...[
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _items.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 4),
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return CartItemTile(
                      item: item,
                      onIncrement: () => _increment(index),
                      onDecrement: () => _decrement(index),
                    );
                  },
                ),

                const SizedBox(height: 16),

                // "+ Add something else" button
                Center(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFDCE3D5), width: 1.2),
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.forest,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 11,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      '+ Add something else',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.forest,
                      ),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 28),

              // Pickup only Info Card
              _buildPickupCard(),

              const SizedBox(height: 26),

              // Order Summary
              OrderSummary(
                subtotal: _subtotal,
                serviceFee: _items.isNotEmpty ? _serviceFee : 0,
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 8, 28, 16),
          child: PrimaryButton(
            text: 'Choose pickup time',
            trailing: const Icon(
              Icons.arrow_forward_rounded,
              color: AppColors.lime,
              size: 20,
            ),
            onPressed: _items.isEmpty
                ? () {}
                : () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 2),
                        content: Text(
                          'Proceeding to pickup time with $_totalItems items (Rs. ${_subtotal + _serviceFee})',
                        ),
                      ),
                    );
                  },
          ),
        ),
      ),
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
                'Cart',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.muted,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16), // Symmetrical balancing
        ],
      ),
    );
  }

  Widget _buildPickupCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFEFA),
        borderRadius: BorderRadius.circular(16.5),
        border: Border.all(color: const Color(0xFFE5E7DE), width: 1.2),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFEDF1E7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.shopping_bag_outlined,
              color: AppColors.forest,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pickup only',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: AppColors.ink,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Your order will be waiting at the café.',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: AppColors.subtext,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
