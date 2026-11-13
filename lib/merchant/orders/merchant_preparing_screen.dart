import 'package:flutter/material.dart';
import 'package:piko/shared/theme/app_colors.dart';
import 'package:piko/shared/widgets/piko_button.dart';

class MerchantPreparingScreen extends StatefulWidget {
  final String orderId;
  final String customer;
  final String items;
  final String pickup;

  const MerchantPreparingScreen({
    super.key,
    required this.orderId,
    required this.customer,
    required this.items,
    required this.pickup,
  });

  @override
  State<MerchantPreparingScreen> createState() =>
      _MerchantPreparingScreenState();
}

class _MerchantPreparingScreenState
    extends State<MerchantPreparingScreen> {
  final Set<int> _checkedItems = {};

  @override
  Widget build(BuildContext context) {
    final items = widget.items
        .split(' · ')
        .where((item) => item.trim().isNotEmpty)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.ivory,
      appBar: AppBar(
        backgroundColor: AppColors.ivory,
        foregroundColor: AppColors.forest,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          'Preparing order',
          style: TextStyle(fontSize: 13),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF0DE),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Preparing',
                  style: TextStyle(
                    color: AppColors.forest,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'A little care\nin every order.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Order #${widget.orderId} · ${widget.customer}',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF75746E),
              ),
            ),
            const SizedBox(height: 24),
            _card(
              Row(
                children: [
                  const Icon(
                    Icons.schedule,
                    color: AppColors.forest,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Pickup at ${widget.pickup}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Preparation checklist',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 12),
            ...List.generate(items.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _card(
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.trailing,
                    activeColor: AppColors.forest,
                    title: Text(
                      items[index],
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.ink,
                      ),
                    ),
                    value: _checkedItems.contains(index),
                    onChanged: (checked) {
                      setState(() {
                        if (checked == true) {
                          _checkedItems.add(index);
                        } else {
                          _checkedItems.remove(index);
                        }
                      });
                    },
                  ),
                ),
              );
            }),
            const SizedBox(height: 12),
            _card(
              const Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: AppColors.forest,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Everything packed?\nCheck the items before marking ready.',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.ink,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            PrimaryButton(
              text: 'Mark ready for pickup',
              onPressed: () {
                if (_checkedItems.length != items.length) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please check all items first.'),
                    ),
                  );
                  return;
                }

                Navigator.pop(context, 'Ready');
              },
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
}