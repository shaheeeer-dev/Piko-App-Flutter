import 'package:flutter/material.dart';
import 'package:piko/customer/home/home_screen.dart';
import 'package:piko/shared/theme/app_colors.dart';
import 'package:piko/shared/widgets/piko_button.dart';

class OrderSuccessScreen extends StatelessWidget {
  final String orderId;
  final String restaurantName;
  final String restaurantLocation;
  final String pickupTime;
  final String paymentMethod;
  final int totalPrice;
  final List<Map<String, dynamic>>? items;

  const OrderSuccessScreen({
    super.key,
    this.orderId = '#1042',
    this.restaurantName = 'June Coffee',
    this.restaurantLocation = '24 Main Boulevard, Gulberg',
    this.pickupTime = '12:30 PM',
    this.paymentMethod = 'Paid with Visa •••• 4242',
    this.totalPrice = 1120,
    this.items,
  });

  String _formatCurrency(int amount) {
    final str = amount.toString();
    if (str.length <= 3) return str;
    return '${str.substring(0, str.length - 3)},${str.substring(str.length - 3)}';
  }

  @override
  Widget build(BuildContext context) {
    final displayItems = items ??
        [
          {
            'title': 'Honey oat latte',
            'subtitle': 'Oat milk • a little sweetness',
            'price': 650,
            'isDrink': true,
          },
          {
            'title': 'Butter croissant',
            'subtitle': '1 item',
            'price': 420,
            'isDrink': false,
          },
        ];

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

              const SizedBox(height: 20),

              // Order ID badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDF1E7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Order $orderId',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.forest,
                    letterSpacing: -0.2,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Headline & Subtitle (Figma: "You're on the list." / "June Coffee has received your order.")
              const Text(
                "You're on the list.",
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

              Text(
                '$restaurantName has received your order.',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subtext,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 24),

              // Pickup Card
              _buildPickupCard(),

              const SizedBox(height: 24),

              // Ordered Items Card
              _buildItemsCard(displayItems),

              const SizedBox(height: 20),

              // Payment confirmation line
              _buildPaymentLine(),

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
            text: 'Track my order',
            trailing: const Icon(
              Icons.arrow_forward_rounded,
              color: AppColors.lime,
              size: 20,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
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
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
              );
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
                'Order confirmed',
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

  Widget _buildPickupCard() {
    final locationText = restaurantLocation.contains('Today')
        ? restaurantLocation
        : 'Today • $restaurantLocation';

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
              Icons.storefront_outlined,
              color: AppColors.forest,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pickup at $pickupTime',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: AppColors.ink,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  locationText,
                  style: const TextStyle(
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

  Widget _buildItemsCard(List<Map<String, dynamic>> itemList) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFEFA),
        borderRadius: BorderRadius.circular(16.5),
        border: Border.all(color: const Color(0xFFE5E7DE), width: 1.2),
      ),
      child: Column(
        children: [
          for (int i = 0; i < itemList.length; i++) ...[
            if (i > 0)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(color: Color(0xFFE5E7DE), thickness: 1, height: 1),
              ),
            _buildItemRow(itemList[i]),
          ],
        ],
      ),
    );
  }

  Widget _buildItemRow(Map<String, dynamic> item) {
    final title = item['title'] as String? ?? 'Item';
    final subtitle = item['subtitle'] as String? ?? '';
    final price = item['price'] as int? ?? 0;
    final isDrink = item['isDrink'] as bool? ?? true;

    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isDrink ? const Color(0xFFFBF4E6) : const Color(0xFFF8EFDE),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            isDrink ? Icons.coffee_rounded : Icons.bakery_dining_rounded,
            color: const Color(0xFFB97130),
            size: 20,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
              ),
              if (subtitle.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w400,
                    color: AppColors.subtext,
                  ),
                ),
              ],
            ],
          ),
        ),
        Text(
          'Rs. ${_formatCurrency(price)}',
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
            color: AppColors.ink,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentLine() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            paymentMethod,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.subtext,
            ),
          ),
          Text(
            'Rs. ${_formatCurrency(totalPrice)}',
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
        ],
      ),
    );
  }
}
