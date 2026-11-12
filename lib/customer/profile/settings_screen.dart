import 'package:flutter/material.dart';
import 'package:piko/customer/auth/login_screen.dart';
import 'package:piko/shared/theme/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const SettingsScreen({super.key, this.onBack});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _orderUpdates = true;
  bool _newsAndOffers = false;

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

              // Title & Subtitle (Figma Article-20)
              const Text(
                'Just how you like it.',
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
                'A few preferences for your everyday.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subtext,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 24),

              // Preferences Container
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFEFA),
                  borderRadius: BorderRadius.circular(16.5),
                  border:
                      Border.all(color: const Color(0xFFE5E7DE), width: 1.2),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    _buildSwitchTile(
                      title: 'Order updates',
                      subtitle: 'Pickup reminders and order status',
                      value: _orderUpdates,
                      onChanged: (val) => setState(() => _orderUpdates = val),
                    ),
                    const Divider(color: Color(0xFFE5E7DE), height: 1),
                    _buildSwitchTile(
                      title: 'News & offers',
                      subtitle: 'Occasional good things from Piko',
                      value: _newsAndOffers,
                      onChanged: (val) => setState(() => _newsAndOffers = val),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Links List
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFEFA),
                  borderRadius: BorderRadius.circular(16.5),
                  border:
                      Border.all(color: const Color(0xFFE5E7DE), width: 1.2),
                ),
                child: Column(
                  children: [
                    _buildLinkTile(
                      title: 'Help & support',
                      onTap: () => _showMessage('Help & support center'),
                    ),
                    const Divider(color: Color(0xFFE5E7DE), height: 1),
                    _buildLinkTile(
                      title: 'Privacy policy',
                      onTap: () => _showMessage('Privacy policy'),
                    ),
                    const Divider(color: Color(0xFFE5E7DE), height: 1),
                    _buildLinkTile(
                      title: 'Terms of service',
                      onTap: () => _showMessage('Terms of service'),
                    ),
                    const Divider(color: Color(0xFFE5E7DE), height: 1),
                    _buildLinkTile(
                      title: 'About Piko',
                      trailingText: 'Version 1.0',
                      onTap: () => _showMessage('Piko App v1.0.0'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Log out button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: _showLogoutDialog,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFDCE2D6), width: 1.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Log out',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ink,
                    ),
                  ),
                ),
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
              if (widget.onBack != null) {
                widget.onBack!();
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
                'Settings',
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

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    color: AppColors.subtext,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            activeTrackColor: AppColors.forest,
            activeThumbColor: AppColors.ivory,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildLinkTile({
    required String title,
    String? trailingText,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.ink,
              ),
            ),
            if (trailingText != null)
              Text(
                trailingText,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  color: AppColors.subtext,
                ),
              )
            else
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

  void _showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  void _showLogoutDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.ivory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Log out',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
          content: const Text(
            'Are you sure you want to log out of your Piko account?',
            style: TextStyle(
              fontFamily: 'Inter',
              color: AppColors.subtext,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.subtext,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.forest,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Log out',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.ivory,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

