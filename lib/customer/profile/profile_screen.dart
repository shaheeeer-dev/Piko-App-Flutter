import 'package:flutter/material.dart';
import 'package:piko/customer/home/favorites_screen.dart';
import 'package:piko/customer/profile/edit_profile_screen.dart';
import 'package:piko/customer/profile/notifications_screen.dart';
import 'package:piko/customer/profile/settings_screen.dart';
import 'package:piko/shared/theme/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const ProfileScreen({super.key, this.onBack});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = 'Ayesha Khan';
  String _userEmail = 'ayesha@example.com';
  String _userPhone = '+92 300 123 4567';
  String _userNeighborhood = 'Gulberg, Lahore';

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

              // User Info Header (Avatar, Name, Email, Edit Action)
              _buildUserHeader(),

              const SizedBox(height: 28),

              // Menu Items Container (Favorites, Payment, Notifications, Settings)
              _buildMenuSection(),

              const SizedBox(height: 28),

              // Tagline Banner Card (Figma Article-18: "A LITTLE EVERYDAY JOY • See you at your next pickup.")
              _buildTaglineCard(),

              const SizedBox(height: 32),
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
          const Expanded(
            child: Center(
              child: Text(
                'Profile',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.muted,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserHeader() {
    return Row(
      children: [
        // Avatar Circle with Initials
        Container(
          width: 54,
          height: 54,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color(0xFFE5EBD8),
            shape: BoxShape.circle,
          ),
          child: Text(
            _getInitials(_userName),
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.forest,
            ),
          ),
        ),

        const SizedBox(width: 16),

        // Name, Email & Edit Button
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _userName,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _userEmail,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subtext,
                ),
              ),
            ],
          ),
        ),

        // Edit profile button
        GestureDetector(
          onTap: () async {
            final result = await Navigator.push<Map<String, String>>(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfileScreen(
                  initialName: _userName,
                  initialEmail: _userEmail,
                  initialPhone: _userPhone,
                  initialNeighborhood: _userNeighborhood,
                ),
              ),
            );
            if (result != null) {
              setState(() {
                _userName = result['name'] ?? _userName;
                _userEmail = result['email'] ?? _userEmail;
                _userPhone = result['phone'] ?? _userPhone;
                _userNeighborhood =
                    result['neighborhood'] ?? _userNeighborhood;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFEEF0E8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Edit',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: AppColors.forest,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSection() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFEFA),
        borderRadius: BorderRadius.circular(16.5),
        border: Border.all(color: const Color(0xFFE5E7DE), width: 1.2),
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.bookmark_outline_rounded,
            title: 'My favorites',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesScreen(),
                ),
              );
            },
          ),
          const Divider(color: Color(0xFFE5E7DE), height: 1),
          _buildMenuItem(
            icon: Icons.credit_card_rounded,
            title: 'Payment methods',
            onTap: _showPaymentMethodsModal,
          ),
          const Divider(color: Color(0xFFE5E7DE), height: 1),
          _buildMenuItem(
            icon: Icons.notifications_none_rounded,
            title: 'Notifications',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
          ),
          const Divider(color: Color(0xFFE5E7DE), height: 1),
          _buildMenuItem(
            icon: Icons.settings_outlined,
            title: 'Settings & support',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: AppColors.forest,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.ink,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: AppColors.muted,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaglineCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.forest,
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A LITTLE EVERYDAY JOY',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                    color: AppColors.lime,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'See you at\nyour next pickup.',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ivory,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.coffee_rounded,
            size: 38,
            color: AppColors.lime,
          ),
        ],
      ),
    );
  }

  void _showPaymentMethodsModal() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.ivory,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: const EdgeInsets.fromLTRB(28, 14, 28, 28),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: AppColors.line,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const Text(
                  'Saved payment methods',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFEFA),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE5E7DE)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.credit_card, color: AppColors.forest),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Visa ending in 4242',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                color: AppColors.ink,
                              ),
                            ),
                            Text(
                              'Expires 08/28 • Default',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                color: AppColors.subtext,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.check_circle_rounded,
                          color: AppColors.forest, size: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts[0].isEmpty) return 'AK';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
}

