import 'package:flutter/material.dart';
import 'package:piko/shared/theme/app_colors.dart';

class MerchantPickupQueueScreen extends StatefulWidget {
  final List<Map<String, String>> orders;
  final ValueChanged<String> onCollected;

  const MerchantPickupQueueScreen({
    super.key,
    required this.orders,
    required this.onCollected,
  });

  @override
  State<MerchantPickupQueueScreen> createState() =>
      _MerchantPickupQueueScreenState();
}

class _MerchantPickupQueueScreenState
    extends State<MerchantPickupQueueScreen> {
  String _selected = 'Ready';

  Future<void> _collect(Map<String, String> order) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Collect order #${order['id']}?'),
        content: const Text(
          'Confirm that the customer has received this order.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );

    if (!mounted || confirmed != true) return;

    widget.onCollected(order['id']!);

    setState(() {
      order['status'] = 'Collected';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Order #${order['id']} collected.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visible = widget.orders
        .where((order) => order['status'] == _selected)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.ivory,
      appBar: AppBar(
        title: const Text(
          'Pickup queue',
          style: TextStyle(fontSize: 13),
        ),
        centerTitle: true,
        backgroundColor: AppColors.ivory,
        foregroundColor: AppColors.forest,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Text(
              'Ready when\nthey are.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Today’s pickups, in one place.',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF75746E),
              ),
            ),
            const SizedBox(height: 22),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['Ready', 'Preparing', 'Collected'].map((status) {
                return ChoiceChip(
                  label: Text(status),
                  selected: _selected == status,
                  showCheckmark: false,
                  selectedColor: AppColors.forest,
                  backgroundColor: AppColors.ivory,
                  labelStyle: TextStyle(
                    color: _selected == status
                        ? Colors.white
                        : AppColors.forest,
                  ),
                  onSelected: (_) {
                    setState(() => _selected = status);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            if (visible.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Text('No orders in this queue.'),
                ),
              ),
            ...visible.map((order) {
              final isReady = order['status'] == 'Ready';

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isReady
                      ? const Color(0xFFEAF0DE)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFE0E4D9),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      isReady ? 'READY FOR COLLECTION' : order['status']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.forest,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      order['id']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 4,
                        color: AppColors.forest,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      order['customer']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      order['items']!,
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Pickup at ${order['pickup']}',
                      style: const TextStyle(
                        color: AppColors.forest,
                        fontSize: 13,
                      ),
                    ),
                    if (isReady) ...[
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => _collect(order),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.forest,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text('Confirm collection'),
                      ),
                    ],
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}