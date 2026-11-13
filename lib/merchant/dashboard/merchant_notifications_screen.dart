import 'package:flutter/material.dart';
import 'package:piko/shared/theme/app_colors.dart';

class MerchantNotificationsScreen extends StatefulWidget {
  const MerchantNotificationsScreen({super.key});

  @override
  State<MerchantNotificationsScreen> createState() =>
      _MerchantNotificationsScreenState();
}

class _MerchantNotificationsScreenState
    extends State<MerchantNotificationsScreen> {
  bool _unreadOnly = false;

  // Demo notifications: reset when the app restarts.
  static final List<_MerchantNotification> _notifications = [
    _MerchantNotification(
      title: 'New order #1044',
      message: 'A sample order is waiting for your attention.',
      time: '5 minutes ago',
      icon: Icons.receipt_long_outlined,
    ),
    _MerchantNotification(
      title: 'Your menu is up to date',
      message: 'Your latest menu changes are ready to view.',
      time: '20 minutes ago',
      icon: Icons.restaurant_menu,
    ),
    _MerchantNotification(
      title: 'A little reminder',
      message: 'Check item availability before your next busy period.',
      time: '1 hour ago',
      icon: Icons.inventory_2_outlined,
    ),
    _MerchantNotification(
      title: 'Welcome to your workspace',
      message: 'Manage your orders, menu and pickups in one place.',
      time: 'Yesterday',
      icon: Icons.storefront_outlined,
      read: true,
    ),
  ];

  Future<void> _openNotification(_MerchantNotification notification) async {
    setState(() => notification.read = true);

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(notification.title),
        content: Text(notification.message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount =
        _notifications.where((notification) => !notification.read).length;

    final visible = _notifications.where((notification) {
      return !_unreadOnly || !notification.read;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.ivory,
      appBar: AppBar(
        backgroundColor: AppColors.ivory,
        foregroundColor: AppColors.forest,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          'Merchant notifications',
          style: TextStyle(fontSize: 13),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Text(
              'At a glance.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Demo notifications · Your latest updates.',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF75746E),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '$unreadCount unread',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.forest,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: unreadCount == 0
                      ? null
                      : () {
                    setState(() {
                      for (final notification in _notifications) {
                        notification.read = true;
                      }
                    });
                  },
                  child: const Text('Mark all read'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: [false, true].map((unread) {
                final selected = _unreadOnly == unread;

                return ChoiceChip(
                  label: Text(unread ? 'Unread' : 'All'),
                  selected: selected,
                  showCheckmark: false,
                  selectedColor: AppColors.forest,
                  backgroundColor: AppColors.ivory,
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : AppColors.forest,
                  ),
                  onSelected: (_) {
                    setState(() => _unreadOnly = unread);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            if (visible.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Text(
                    'You’re all caught up.',
                    style: TextStyle(color: AppColors.forest),
                  ),
                ),
              ),
            ...visible.map((notification) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Material(
                  color: notification.read
                      ? Colors.white
                      : const Color(0xFFEAF0DE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: const BorderSide(
                      color: Color(0xFFE0E4D9),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => _openNotification(notification),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            notification.icon,
                            color: AppColors.forest,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notification.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.ink,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  notification.message,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF75746E),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  notification.time,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.forest,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (!notification.read)
                            const Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Icon(
                                Icons.circle,
                                size: 8,
                                color: AppColors.forest,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _MerchantNotification {
  final String title;
  final String message;
  final String time;
  final IconData icon;
  bool read;

  _MerchantNotification({
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    this.read = false,
  });
}