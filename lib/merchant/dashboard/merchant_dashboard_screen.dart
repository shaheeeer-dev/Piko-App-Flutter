import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../orders/merchant_orders_screen.dart';
import 'package:piko/shared/theme/app_colors.dart';
import '../menu/merchant_menu_screen.dart';
import 'merchant_analytics_screen.dart';
import 'merchant_notifications_screen.dart';
import '../profile/merchant_business_profile_screen.dart';
class MerchantDashboardScreen extends StatelessWidget {
  final String businessName;
  final String category;
  final String address;
  final String phone;
  final String email;
  final String openingHours;
  final int preparationMinutes;
  final int slotMinutes;
  final int ordersPerSlot;
  final String pickupInstructions;

  const MerchantDashboardScreen({
    super.key,
    required this.businessName,
    required this.category,
    required this.address,
    required this.phone,
    required this.email,
    required this.openingHours,
    required this.preparationMinutes,
    required this.slotMinutes,
    required this.ordersPerSlot,
    required this.pickupInstructions,
  });

  String get greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  void _pending(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('This screen is not connected yet.')),
    );
  }

  Widget _stat(String title, String value, String subtitle) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFEAF0DE),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF75746E),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE0E4D9)),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ivory,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.ivory,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          'Dashboard',
          style: TextStyle(fontSize: 13, color: Color(0xFF75746E)),
        ),
        actions: [
          IconButton(
            tooltip: 'Notifications',
            icon: const Icon(
              Icons.notifications_none,
              color: AppColors.forest,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MerchantNotificationsScreen(),
                ),
              );
            },
          ),
          IconButton(
            tooltip: 'Analytics',
            icon: const Icon(
              Icons.bar_chart,
              color: AppColors.forest,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MerchantAnalyticsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/piko_logo.svg',
                    height: 28,
                    width: 28,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'piko',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: AppColors.ink,
                    ),
                  ),
                  const Spacer(),
                  const Chip(
                    label: Text(
                      'Demo preview',
                      style: TextStyle(fontSize: 10),
                    ),
                    backgroundColor: Color(0xFFEAF0DE),
                    side: BorderSide.none,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                '$greeting,\n$businessName.',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 28,
                  height: 1.15,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                MaterialLocalizations.of(context)
                    .formatFullDate(DateTime.now()),
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF75746E),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  _stat("Today's sales", 'Rs. 18,450', 'Sample sales'),
                  const SizedBox(width: 12),
                  _stat('Orders', '24', 'Sample orders'),
                ],
              ),
              const SizedBox(height: 18),
              _card(
                const Row(
                  children: [
                    Icon(
                      Icons.notifications_none,
                      color: AppColors.forest,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '3 new orders',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Your next good moment is waiting.',
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Up next',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextButton(
                    onPressed: () => _pending(context),
                    child: const Text(
                      'View queue',
                      style: TextStyle(color: AppColors.forest),
                    ),
                  ),
                ],
              ),
              _card(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '#1042',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'Preparing',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.forest,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Ayesha K.',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('2 items · Rs. 1,120'),
                        Text('12:30 PM'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '1 Honey oat latte · 1 Butter croissant',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF75746E),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Your pickup settings',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              _card(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Opening hours: $openingHours'),
                    const SizedBox(height: 10),
                    Text('Preparation: $preparationMinutes minutes'),
                    const SizedBox(height: 10),
                    Text('$ordersPerSlot orders per $slotMinutes-minute slot'),
                    const SizedBox(height: 10),
                    Text(
                      pickupInstructions,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF75746E),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.ivory,
        selectedItemColor: AppColors.forest,
        unselectedItemColor: const Color(0xFF75746E),
        selectedFontSize: 11,
        unselectedFontSize: 11,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MerchantOrdersScreen(),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MerchantMenuScreen(),
              ),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MerchantBusinessProfileScreen(
                  businessName: businessName,
                  category: category,
                  address: address,
                  phone: phone,
                  email: email,
                  openingHours: openingHours,
                  preparationMinutes: preparationMinutes,
                  slotMinutes: slotMinutes,
                  ordersPerSlot: ordersPerSlot,
                  pickupInstructions: pickupInstructions,
                ),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_outlined),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}