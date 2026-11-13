import 'package:flutter/material.dart';
import 'merchant_preparing_screen.dart';
import 'package:piko/shared/theme/app_colors.dart';
import 'package:piko/shared/widgets/piko_button.dart';

class MerchantOrderDetailsScreen extends StatefulWidget {
  final String orderId;
  final String customer;
  final String items;
  final String total;
  final String pickup;
  final String status;

  const MerchantOrderDetailsScreen({
    super.key,
    required this.orderId,
    required this.customer,
    required this.items,
    required this.total,
    required this.pickup,
    required this.status,
  });

  @override
  State<MerchantOrderDetailsScreen> createState() =>
      _MerchantOrderDetailsScreenState();
}

class _MerchantOrderDetailsScreenState
    extends State<MerchantOrderDetailsScreen> {
  String get _buttonText {
    switch (widget.status) {
      case 'New':
        return 'Accept & start preparing';
      case 'Preparing':
        return 'Mark ready for pickup';
      case 'Ready':
        return 'Confirm collection';
      default:
        return 'Back to orders';
    }
  }

  Future<void> _updateStatus() async {
    if (widget.status == 'New' || widget.status == 'Preparing') {
      final result = await Navigator.push<String>(
        context,
        MaterialPageRoute(
          builder: (_) => MerchantPreparingScreen(
            orderId: widget.orderId,
            customer: widget.customer,
            items: widget.items,
            pickup: widget.pickup,
          ),
        ),
      );

      if (!mounted) return;

      Navigator.pop(context, result ?? 'Preparing');
      return;
    }

    if (widget.status == 'Ready') {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text('Collect order #${widget.orderId}?'),
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

      Navigator.pop(context, 'Collected');
      return;
    }

    Navigator.pop(context);
  }

  Widget _card(Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
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
    final itemLines = widget.items.split(' · ');

    return Scaffold(
      backgroundColor: AppColors.ivory,
      appBar: AppBar(
        backgroundColor: AppColors.ivory,
        foregroundColor: AppColors.forest,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          'Order detail',
          style: TextStyle(fontSize: 13),
        ),
        leading: IconButton(
          tooltip: 'Back to orders',
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => Navigator.pop(context),
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
                child: Text(
                  widget.status,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.forest,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Order #${widget.orderId}',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.customer,
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
              'Order items',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 12),

            ...itemLines.map(
                  (item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _card(
                  Row(
                    children: [
                      const Icon(
                        Icons.restaurant_outlined,
                        color: AppColors.forest,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.ink,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),
            _card(
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink,
                    ),
                  ),
                  Text(
                    widget.total,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.forest,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            PrimaryButton(
              text: _buttonText,
              onPressed: _updateStatus,
            ),
          ],
        ),
      ),
    );
  }
}