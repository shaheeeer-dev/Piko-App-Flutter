import 'package:flutter/material.dart';
import 'package:piko/customer/orders/active_order_screen.dart';
import 'package:piko/customer/orders/pickup_code_screen.dart';
import 'package:piko/shared/theme/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const NotificationsScreen({super.key, this.onBack});

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

              // Title: "A little heads-up" (Figma Article-17)
              const Text(
                'A little heads-up',
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
                'Updates worth a moment.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subtext,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 24),

              // Recent Notifications
              _buildNotificationTile(
                context: context,
                title: 'Your order is ready!',
                subtitle: 'June Coffee • Order #1042 • Just now',
                icon: Icons.check_circle_outline_rounded,
                isUnread: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PickupCodeScreen(
                        orderId: '1042',
                        restaurantName: 'June Coffee',
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 12),

              _buildNotificationTile(
                context: context,
                title: 'Your coffee is in good hands',
                subtitle: 'Order accepted • 14 minutes ago',
                icon: Icons.coffee_rounded,
                isUnread: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ActiveOrderScreen(
                        orderId: '1042',
                        restaurantName: 'June Coffee',
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // Section: Earlier
              const Text(
                'Earlier',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.subtext,
                ),
              ),

              const SizedBox(height: 12),

              _buildNotificationTile(
                context: context,
                title: 'Thanks for stopping by',
                subtitle: 'Your receipt for order #1028 • Oct 1',
                icon: Icons.receipt_long_outlined,
                isUnread: false,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Receipt sent to ayesha@example.com'),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),
            ],
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
              if (onBack != null) {
                onBack!();
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
                'Notifications',
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

  Widget _buildNotificationTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isUnread,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFEFA),
        borderRadius: BorderRadius.circular(16.5),
        border: Border.all(
          color: isUnread ? const Color(0xFFDCE2D6) : const Color(0xFFE5E7DE),
          width: 1.2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.5),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isUnread
                      ? const Color(0xFFEDF1E7)
                      : const Color(0xFFF4F6F0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: isUnread ? AppColors.forest : AppColors.muted,
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
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: isUnread ? FontWeight.w700 : FontWeight.w600,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.subtext,
                      ),
                    ),
                  ],
                ),
              ),
              if (isUnread)
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.forest,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

