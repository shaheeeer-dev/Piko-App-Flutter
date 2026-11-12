import 'package:flutter/material.dart';
import 'package:piko/customer/home/home_screen.dart';
import 'package:piko/shared/theme/app_colors.dart';
import 'package:piko/shared/widgets/piko_button.dart';

class PickupCodeScreen extends StatelessWidget {
  final String orderId;
  final String restaurantName;
  final String restaurantLocation;
  final String pickupTime;
  final int totalPrice;
  final List<Map<String, dynamic>>? items;

  const PickupCodeScreen({
    super.key,
    this.orderId = '1042',
    this.restaurantName = 'June Coffee',
    this.restaurantLocation = '24 Main Boulevard',
    this.pickupTime = '12:30 PM',
    this.totalPrice = 1120,
    this.items,
  });

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

              const SizedBox(height: 20),

              // Status Pill Badge ("Ready to go")
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EFDB),
                  borderRadius: BorderRadius.circular(8.68),
                ),
                child: const Text(
                  'Ready to go',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.forest,
                    letterSpacing: -0.2,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Headline: "Your happy moment\nis ready." (Figma Article-14)
              const Text(
                'Your happy moment\nis ready.',
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
                'Head to the pickup counter at $restaurantName.',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subtext,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 28),

              // Dashed Pickup Code Box
              _buildPickupCodeBox(),

              const SizedBox(height: 24),

              // Location & Walk info card
              _buildLocationCard(),

              const SizedBox(height: 16),

              // Timing note
              Text(
                'Please collect around $pickupTime so everything tastes its best.',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subtext,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 24),

              // Secondary Button: "Get directions"
              _buildGetDirectionsButton(context),

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
            text: 'View order',
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
                'Ready for pickup',
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

  Widget _buildPickupCodeBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF0DF),
        borderRadius: BorderRadius.circular(21.5),
        border: Border.all(
          color: const Color(0xFFAEBFA0),
          width: 1.8,
        ),
      ),
      child: Column(
        children: [
          const Text(
            'YOUR PICKUP CODE',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
              color: Color(0xFF78816E),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            orderId,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 48,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
              color: AppColors.forest,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Show this number to the team',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: AppColors.forest,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard() {
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
                  '$restaurantName • Gulberg',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: AppColors.ink,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$restaurantLocation - 8 min walk',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: AppColors.subtext,
                    fontSize: 12,
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

  Widget _buildGetDirectionsButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: OutlinedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Opening directions to $restaurantName...'),
            ),
          );
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFFEEF0E8),
          side: const BorderSide(color: Color(0xFFDCE2D6), width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.5),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.navigation_outlined,
              size: 16,
              color: AppColors.ink,
            ),
            SizedBox(width: 8),
            Text(
              'Get directions',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: AppColors.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
