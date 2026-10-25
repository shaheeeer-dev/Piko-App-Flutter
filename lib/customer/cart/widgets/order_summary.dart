import 'package:flutter/material.dart';
import 'package:piko/shared/theme/app_colors.dart';

class OrderSummary extends StatelessWidget {
  final int subtotal;
  final int serviceFee;

  const OrderSummary({
    super.key,
    required this.subtotal,
    this.serviceFee = 50,
  });

  int get total => subtotal > 0 ? subtotal + serviceFee : 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Subtotal row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Subtotal',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.subtext,
              ),
            ),
            Text(
              'Rs. ${_formatCurrency(subtotal)}',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.ink,
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // Service fee row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Service fee',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.subtext,
              ),
            ),
            Text(
              subtotal > 0 ? 'Rs. ${_formatCurrency(serviceFee)}' : 'Rs. 0',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.ink,
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        const Divider(color: AppColors.line, thickness: 1, height: 1),

        const SizedBox(height: 14),

        // Total row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
                letterSpacing: -0.3,
              ),
            ),
            Text(
              'Rs. ${_formatCurrency(total)}',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatCurrency(int amount) {
    final str = amount.toString();
    if (str.length <= 3) return str;
    return '${str.substring(0, str.length - 3)},${str.substring(str.length - 3)}';
  }
}
