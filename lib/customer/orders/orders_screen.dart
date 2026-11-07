import 'package:flutter/material.dart';
import 'package:piko/customer/orders/active_order_screen.dart';
import 'package:piko/shared/theme/app_colors.dart';

class OrderItemData {
  final String id;
  final String orderId;
  final String restaurantName;
  final String dateLabel;
  final String itemsSummary;
  final int totalPrice;
  final String status;
  final bool isActive;

  const OrderItemData({
    required this.id,
    required this.orderId,
    required this.restaurantName,
    required this.dateLabel,
    required this.itemsSummary,
    required this.totalPrice,
    required this.status,
    this.isActive = false,
  });
}

class OrdersScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final bool showBackButton;

  const OrdersScreen({
    super.key,
    this.onBack,
    this.showBackButton = true,
  });

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int _selectedFilterIndex = 0; // 0: All, 1: Active

  final List<OrderItemData> _orders = const [
    OrderItemData(
      id: 'ord_1',
      orderId: '1042',
      restaurantName: 'June Coffee',
      dateLabel: 'Today • 12:30 PM',
      itemsSummary: 'Honey oat latte, Butter croissant',
      totalPrice: 1120,
      status: 'Preparing',
      isActive: true,
    ),
    OrderItemData(
      id: 'ord_2',
      orderId: '1028',
      restaurantName: 'Mocca',
      dateLabel: 'Yesterday • 3:15 PM',
      itemsSummary: 'Flat white',
      totalPrice: 580,
      status: 'Completed',
      isActive: false,
    ),
    OrderItemData(
      id: 'ord_3',
      orderId: '0981',
      restaurantName: 'June Coffee',
      dateLabel: '14 Oct • 10:00 AM',
      itemsSummary: 'Vanilla latte',
      totalPrice: 620,
      status: 'Completed',
      isActive: false,
    ),
  ];

  String _formatCurrency(int amount) {
    final str = amount.toString();
    if (str.length <= 3) return str;
    return '${str.substring(0, str.length - 3)},${str.substring(str.length - 3)}';
  }

  @override
  Widget build(BuildContext context) {
    final filteredOrders = _selectedFilterIndex == 1
        ? _orders.where((o) => o.isActive).toList()
        : _orders;

    return Scaffold(
      backgroundColor: AppColors.ivory,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(28, 12, 28, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              _buildTopBar(context),

              const SizedBox(height: 18),

              // Title & Subtitle (Figma Article-15)
              const Text(
                'Orders',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                  letterSpacing: -1.0,
                  height: 1.15,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Track ongoing pickups and view order history.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subtext,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 20),

              // Filter Chips: All / Active
              _buildFilterChips(),

              const SizedBox(height: 20),

              // Orders List
              if (filteredOrders.isEmpty)
                _buildEmptyState()
              else
                ...filteredOrders.map((order) => _buildOrderCard(order)),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return SizedBox(
      height: 28,
      child: Row(
        children: [
          if (widget.showBackButton)
            IconButton(
              onPressed: () {
                if (widget.onBack != null) {
                  widget.onBack!();
                } else {
                  Navigator.of(context).maybePop();
                }
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 16,
                color: AppColors.muted,
              ),
            ),
          const Expanded(
            child: Center(
              child: Text(
                'Orders & history',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.muted,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          if (widget.showBackButton) const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Row(
      children: [
        _buildChip(index: 0, label: 'All'),
        const SizedBox(width: 10),
        _buildChip(index: 1, label: 'Active'),
      ],
    );
  }

  Widget _buildChip({required int index, required String label}) {
    final isSelected = _selectedFilterIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedFilterIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.forest : Colors.transparent,
          borderRadius: BorderRadius.circular(11.19),
          border: Border.all(
            color: isSelected ? AppColors.forest : const Color(0xFFDFE4D9),
            width: 1.2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? AppColors.lime : AppColors.ink,
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard(OrderItemData order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFEFA),
        borderRadius: BorderRadius.circular(16.5),
        border: Border.all(color: const Color(0xFFE5E7DE), width: 1.2),
      ),
      child: InkWell(
        onTap: () {
          if (order.isActive) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ActiveOrderScreen(
                  orderId: order.orderId,
                  restaurantName: order.restaurantName,
                  pickupTime: '12:30 PM',
                  totalPrice: order.totalPrice,
                ),
              ),
            );
          } else {
            _showReceiptModal(order);
          }
        },
        borderRadius: BorderRadius.circular(16.5),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Restaurant Name + Status Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order.restaurantName,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8EFDB),
                      borderRadius: BorderRadius.circular(8.68),
                    ),
                    child: Text(
                      order.status,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.forest,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 6),

              // Date & time
              Text(
                order.dateLabel,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subtext,
                ),
              ),

              const SizedBox(height: 10),

              // Items summary & Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      order.itemsSummary,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.ink,
                      ),
                    ),
                  ),
                  Text(
                    'Rs. ${_formatCurrency(order.totalPrice)}',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink,
                    ),
                  ),
                ],
              ),

              if (order.isActive) ...[
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Text(
                      'Tap to view live tracking',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.forest,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 13,
                      color: AppColors.forest,
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.center,
      child: const Column(
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 48,
            color: AppColors.muted,
          ),
          SizedBox(height: 12),
          Text(
            'No active orders',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Your upcoming pickups will show up here.',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              color: AppColors.subtext,
            ),
          ),
        ],
      ),
    );
  }

  void _showReceiptModal(OrderItemData order) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.ivory,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: const EdgeInsets.fromLTRB(28, 14, 28, 28),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: AppColors.line,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  'Order #${order.orderId}',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${order.restaurantName} • ${order.dateLabel}',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    color: AppColors.subtext,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  order.itemsSummary,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Paid',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink,
                      ),
                    ),
                    Text(
                      'Rs. ${_formatCurrency(order.totalPrice)}',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.forest,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Re-ordered from ${order.restaurantName}!'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.forest,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Re-order',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.ivory,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

