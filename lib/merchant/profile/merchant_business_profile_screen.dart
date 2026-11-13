import 'package:flutter/material.dart';
import 'package:piko/shared/theme/app_colors.dart';
import 'merchant_business_settings_screen.dart';
import 'merchant_staff_account_screen.dart';
class MerchantBusinessProfileScreen extends StatefulWidget {
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

  const MerchantBusinessProfileScreen({
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

  @override
  State<MerchantBusinessProfileScreen> createState() =>
      _MerchantBusinessProfileScreenState();
}

class _MerchantBusinessProfileScreenState
    extends State<MerchantBusinessProfileScreen> {
  late Map<String, String> _details;

  @override
  void initState() {
    super.initState();

    _details = {
      'businessName': widget.businessName,
      'category': widget.category,
      'address': widget.address,
      'phone': widget.phone,
      'email': widget.email,
      'openingHours': widget.openingHours,
      'preparationMinutes': '${widget.preparationMinutes}',
      'slotMinutes': '${widget.slotMinutes}',
      'ordersPerSlot': '${widget.ordersPerSlot}',
      'pickupInstructions': widget.pickupInstructions,
    };
  }

  Future<void> _editSettings() async {
    final result = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (_) => MerchantBusinessSettingsScreen(
          details: _details,
        ),
      ),
    );

    if (!mounted || result == null) return;

    setState(() => _details = result);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated for this preview.'),
      ),
    );
  }

  String _value(String key) {
    final value = _details[key] ?? '';
    return value.trim().isEmpty ? 'Not provided' : value;
  }

  Widget _detail(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.forest, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF75746E),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.ink,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE0E4D9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ivory,
      appBar: AppBar(
        backgroundColor: AppColors.ivory,
        foregroundColor: AppColors.forest,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          'Business profile',
          style: TextStyle(fontSize: 13),
        ),
        actions: [
          IconButton(
            tooltip: 'Business settings',
            onPressed: _editSettings,
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Container(
              height: 130,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF0DE),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.storefront_outlined,
                size: 64,
                color: AppColors.forest,
              ),
            ),
            const SizedBox(height: 22),
            Text(
              _value('businessName'),
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _value('category'),
              style: const TextStyle(color: Color(0xFF75746E)),
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              icon: const Icon(Icons.people_outline),
              label: const Text('Staff & account'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.forest,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MerchantStaffAccountScreen(
                      businessName: _details['businessName'] ?? '',
                      email: _details['email'] ?? '',
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 18),
            _section('Business details', [
              _detail(
                Icons.store_outlined,
                'Business name',
                _value('businessName'),
              ),
              _detail(
                Icons.category_outlined,
                'Category',
                _value('category'),
              ),
              _detail(
                Icons.location_on_outlined,
                'Address',
                _value('address'),
              ),
            ]),
            _section('Contact', [
              _detail(Icons.phone_outlined, 'Phone', _value('phone')),
              _detail(Icons.email_outlined, 'Email', _value('email')),
            ]),
            _section('Opening & pickup', [
              _detail(
                Icons.access_time,
                'Opening hours',
                _value('openingHours'),
              ),
              _detail(
                Icons.timer_outlined,
                'Preparation time',
                '${_value('preparationMinutes')} minutes',
              ),
              _detail(
                Icons.calendar_today_outlined,
                'Pickup capacity',
                '${_value('ordersPerSlot')} orders per '
                    '${_value('slotMinutes')}-minute slot',
              ),
              _detail(
                Icons.info_outline,
                'Pickup instructions',
                _value('pickupInstructions'),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}