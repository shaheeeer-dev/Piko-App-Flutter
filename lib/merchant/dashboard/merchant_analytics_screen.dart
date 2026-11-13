import 'package:flutter/material.dart';
import 'package:piko/shared/theme/app_colors.dart';

class MerchantAnalyticsScreen extends StatefulWidget {
  const MerchantAnalyticsScreen({super.key});

  @override
  State<MerchantAnalyticsScreen> createState() =>
      _MerchantAnalyticsScreenState();
}

class _MerchantAnalyticsScreenState
    extends State<MerchantAnalyticsScreen> {
  bool _thisWeek = true;

  final List<int> _currentSales = [
    10000, 12500, 11000, 15000, 18000, 14450, 18450,
  ];

  final List<int> _previousSales = [
    8000, 10500, 9000, 12000, 15000, 11000, 14500,
  ];

  final List<int> _currentOrders = [14, 17, 15, 20, 23, 19, 24];
  final List<int> _previousOrders = [11, 14, 12, 16, 20, 15, 19];

  String _money(int amount) {
    return 'Rs. ${amount.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]},',
    )}';
  }

  Widget _stat(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF0DE),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.forest,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColors.ink,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sales = _thisWeek ? _currentSales : _previousSales;
    final orders = _thisWeek ? _currentOrders : _previousOrders;

    final totalSales = sales.fold<int>(0, (sum, value) => sum + value);
    final totalOrders = orders.fold<int>(0, (sum, value) => sum + value);
    final maxSale = sales.reduce((a, b) => a > b ? a : b);
    final averageOrder = (totalSales / totalOrders).round();

    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Scaffold(
      backgroundColor: AppColors.ivory,
      appBar: AppBar(
        backgroundColor: AppColors.ivory,
        foregroundColor: AppColors.forest,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          'Basic analytics',
          style: TextStyle(fontSize: 13),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Text(
              'Good days,\nin numbers.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Demo analytics · Sample weekly sales',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF75746E),
              ),
            ),
            const SizedBox(height: 22),
            Wrap(
              spacing: 8,
              children: [true, false].map((current) {
                final selected = _thisWeek == current;

                return ChoiceChip(
                  label: Text(current ? 'This week' : 'Last week'),
                  selected: selected,
                  showCheckmark: false,
                  selectedColor: AppColors.forest,
                  backgroundColor: AppColors.ivory,
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : AppColors.forest,
                  ),
                  onSelected: (_) {
                    setState(() => _thisWeek = current);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            _stat('Total sales', _money(totalSales)),
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _stat('Orders', '$totalOrders'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _stat('Average order', _money(averageOrder)),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFFE0E4D9),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Daily sales',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Tap a bar to see its sales.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF75746E),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 190,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(sales.length, (index) {
                        return Expanded(
                          child: InkWell(
                            onTap: () {
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${days[index]}: ${_money(sales[index])}',
                                    ),
                                  ),
                                );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: sales[index] / maxSale * 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: sales[index] == maxSale
                                          ? AppColors.forest
                                          : const Color(0xFF829B76),
                                      borderRadius:
                                      BorderRadius.circular(5),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    days[index],
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Sales breakdown',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 12),
            ...List.generate(sales.length, (index) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(days[index]),
                subtitle: Text('${orders[index]} orders'),
                trailing: Text(
                  _money(sales[index]),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.forest,
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