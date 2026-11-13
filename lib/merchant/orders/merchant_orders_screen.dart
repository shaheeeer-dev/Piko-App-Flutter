import 'package:flutter/material.dart';
import 'merchant_order_details_screen.dart';
import 'package:piko/shared/theme/app_colors.dart';
import 'merchant_pickup_queue_screen.dart';
import 'merchant_pickup_slots_screen.dart';
class MerchantOrdersScreen extends StatefulWidget {
  const MerchantOrdersScreen({super.key});

  @override
  State<MerchantOrdersScreen> createState() =>
      _MerchantOrdersScreenState();
}

class _MerchantOrdersScreenState extends State<MerchantOrdersScreen> {
  String _selectedStatus = 'All';

  final List<String> _filters = [
    'All',
    'New',
    'Preparing',
    'Ready',
    'Collected',
  ];

  static final List<_DemoOrder> _orders = [
    _DemoOrder(
      id: '1042',
      customer: 'Ayesha K.',
      items: '1 Honey oat latte · 1 Butter croissant',
      total: 'Rs. 1,120',
      pickup: '12:30 PM',
      status: 'Preparing',
    ),
    _DemoOrder(
      id: '1043',
      customer: 'Demo customer',
      items: '1 Honey oat latte',
      total: 'Rs. 650',
      pickup: '12:45 PM',
      status: 'New',
    ),
  ];

  String _buttonLabel(String status) {
    switch (status) {
      case 'New':
        return 'Accept & start preparing';
      case 'Preparing':
        return 'Mark ready for pickup';
      case 'Ready':
        return 'Confirm collection';
      default:
        return 'Collected';
    }
  }

  Future<void> _advanceOrder(_DemoOrder order) async {
    if (order.status == 'Collected') return;

    final nextStatus = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => MerchantOrderDetailsScreen(
          orderId: order.id,
          customer: order.customer,
          items: order.items,
          total: order.total,
          pickup: order.pickup,
          status: order.status,
        ),
      ),
    );

    if (!mounted || nextStatus == null) return;

    setState(() {
      order.status = nextStatus;
    });
  }

  Widget _orderCard(_DemoOrder order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE0E4D9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '#${order.id}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.ink,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF0DE),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  order.status,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.forest,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            order.customer,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            order.items,
            style: const TextStyle(
              fontSize: 12,
              height: 1.5,
              color: Color(0xFF75746E),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.total,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
              ),
              Text(
                order.pickup,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.forest,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          if (order.status != 'Collected')
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _advanceOrder(order),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.forest,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Text(
                  _buttonLabel(order.status),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          else
            const Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: AppColors.forest,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Collected',
                  style: TextStyle(color: AppColors.forest),
                ),
              ],
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visibleOrders = _orders.where((order) {
      return _selectedStatus == 'All' ||
          order.status == _selectedStatus;
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
          'Orders',
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          IconButton(
            tooltip: 'Pickup slots',
            icon: const Icon(Icons.schedule),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MerchantPickupSlotsScreen(),
                ),
              );
            },
          ),
          IconButton(
            tooltip: 'Pickup queue',
            icon: const Icon(Icons.list_alt),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MerchantPickupQueueScreen(
                    orders: _orders.map((order) {
                      return <String, String>{
                        'id': order.id,
                        'customer': order.customer,
                        'items': order.items,
                        'pickup': order.pickup,
                        'status': order.status,
                      };
                    }).toList(),
                    onCollected: (id) {
                      if (!mounted) return;

                      setState(() {
                        _orders.firstWhere((order) => order.id == id).status =
                        'Collected';
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ],
        leading: IconButton(
          tooltip: 'Back to dashboard',
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Text(
              'Your orders',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Demo orders · Changes last while this screen is open.',
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                color: Color(0xFF75746E),
              ),
            ),
            const SizedBox(height: 22),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _filters.map((status) {
                final selected = _selectedStatus == status;

                return ChoiceChip(
                  label: Text(status),
                  selected: selected,
                  showCheckmark: false,
                  selectedColor: AppColors.forest,
                  backgroundColor: AppColors.ivory,
                  labelStyle: TextStyle(
                    fontSize: 12,
                    color: selected
                        ? Colors.white
                        : AppColors.forest,
                  ),
                  onSelected: (_) {
                    setState(() => _selectedStatus = status);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            if (visibleOrders.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Text(
                    'No orders in this category.',
                    style: TextStyle(color: Color(0xFF75746E)),
                  ),
                ),
              )
            else
              ...visibleOrders.map(_orderCard),
          ],
        ),
      ),
    );
  }
}

class _DemoOrder {
  final String id;
  final String customer;
  final String items;
  final String total;
  final String pickup;
  String status;

  _DemoOrder({
    required this.id,
    required this.customer,
    required this.items,
    required this.total,
    required this.pickup,
    required this.status,
  });
}