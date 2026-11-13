import 'package:flutter/material.dart';
import 'package:piko/shared/theme/app_colors.dart';

class MerchantAvailabilityScreen extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final void Function(int index, bool available) onChanged;

  const MerchantAvailabilityScreen({
    super.key,
    required this.items,
    required this.onChanged,
  });

  @override
  State<MerchantAvailabilityScreen> createState() =>
      _MerchantAvailabilityScreenState();
}

class _MerchantAvailabilityScreenState
    extends State<MerchantAvailabilityScreen> {
  @override
  Widget build(BuildContext context) {
    final availableCount =
        widget.items.where((item) => item['available'] == true).length;

    return Scaffold(
      backgroundColor: AppColors.ivory,
      appBar: AppBar(
        backgroundColor: AppColors.ivory,
        foregroundColor: AppColors.forest,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          'Availability',
          style: TextStyle(fontSize: 13),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Text(
              'Keep it fresh.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Quickly manage what customers can order.',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF75746E),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF0DE),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.inventory_2_outlined,
                    color: AppColors.forest,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '$availableCount of ${widget.items.length} items available',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.forest,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ...List.generate(widget.items.length, (index) {
              final item = widget.items[index];
              final available = item['available'] as bool;

              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFFE0E4D9),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['name'] as String,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.ink,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            available
                                ? 'Available for orders'
                                : 'Currently unavailable',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF75746E),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: available,
                      activeTrackColor: AppColors.forest,
                      onChanged: (value) {
                        widget.onChanged(index, value);

                        setState(() {
                          item['available'] = value;
                        });
                      },
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 12),
            const Text(
              'Changes apply immediately to your demo menu.',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF75746E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}