import 'package:flutter/material.dart';
import 'package:piko/shared/theme/app_colors.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip(
    this.label, {
    super.key,
    this.selected = false,
    this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  static const _muted = Color(0xFF748076);
  static const _line = Color(0xFFE1E5DB);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.forest : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: selected ? null : Border.all(color: _line),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            color: selected ? AppColors.ivory : _muted,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
