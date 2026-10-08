import 'package:flutter/material.dart';
import 'package:piko/shared/theme/app_colors.dart';

class PikoBottomNavigation extends StatelessWidget {
  const PikoBottomNavigation({
    super.key,
    required this.currentIndex,
    this.onItemSelected,
  });

  final int currentIndex;
  final ValueChanged<int>? onItemSelected;

  static const _line = Color(0xFFE1E5DB);
  static const _muted = Color(0xFF8B958A);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 81,
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 7),
      decoration: const BoxDecoration(
        color: AppColors.ivory,
        border: Border(top: BorderSide(color: _line)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.home_outlined,
            label: 'Home',
            selected: currentIndex == 0,
            onTap: () => onItemSelected?.call(0),
          ),
          _NavItem(
            icon: Icons.search_rounded,
            label: 'Explore',
            selected: currentIndex == 1,
            onTap: () => onItemSelected?.call(1),
          ),
          _NavItem(
            icon: Icons.receipt_long_outlined,
            label: 'Orders',
            selected: currentIndex == 2,
            onTap: () => onItemSelected?.call(2),
          ),
          _NavItem(
            icon: Icons.person_outline_rounded,
            label: 'Profile',
            selected: currentIndex == 3,
            onTap: () => onItemSelected?.call(3),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.forest : PikoBottomNavigation._muted;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 55,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 39,
              height: 39,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? AppColors.lime : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 21),
            ),
            const SizedBox(height: 1),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                color: color,
                fontSize: 9,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
