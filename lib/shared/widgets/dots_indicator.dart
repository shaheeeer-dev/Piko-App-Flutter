import 'package:flutter/material.dart';
import 'package:piko/shared/theme/app_colors.dart';

class DotsIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;
  final double spacing;

  const DotsIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final bool isActive = index == currentIndex;
        return Container(
          margin: EdgeInsets.only(right: index == count - 1 ? 0 : spacing),
          width: isActive ? 26 : 5,
          height: 5,
          decoration: BoxDecoration(
            color: isActive ? AppColors.forest : const Color(0xFFDCD8CF),
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}
