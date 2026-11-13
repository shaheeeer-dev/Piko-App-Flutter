import 'package:flutter/material.dart';
import 'package:piko/shared/theme/app_colors.dart';

class MerchantPickupSlotsScreen extends StatefulWidget {
  const MerchantPickupSlotsScreen({super.key});

  @override
  State<MerchantPickupSlotsScreen> createState() =>
      _MerchantPickupSlotsScreenState();
}

class _MerchantPickupSlotsScreenState
    extends State<MerchantPickupSlotsScreen> {
  String _day = 'Today';
  int _capacity = 5;

  final _times = [
    '12:00 PM',
    '12:15 PM',
    '12:30 PM',
    '12:45 PM',
    '1:00 PM',
  ];

  final _todayBookings = [5, 3, 4, 2, 1];
  final _tomorrowBookings = [1, 0, 2, 0, 1];

  Future<void> _editSettings() async {
    int draftCapacity = _capacity;

    final savedCapacity = await showDialog<int>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, updateDialog) {
            return AlertDialog(
              title: const Text('Pickup settings'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Orders per 15-minute slot'),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        tooltip: 'Decrease capacity',
                        onPressed: draftCapacity > 5
                            ? () {
                          updateDialog(() => draftCapacity--);
                        }
                            : null,
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text(
                        '$draftCapacity',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        tooltip: 'Increase capacity',
                        onPressed: draftCapacity < 20
                            ? () {
                          updateDialog(() => draftCapacity++);
                        }
                            : null,
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Minimum 5 because a slot already has 5 bookings.',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext, draftCapacity);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );

    if (!mounted || savedCapacity == null) return;

    setState(() => _capacity = savedCapacity);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pickup capacity updated for this preview.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookings =
    _day == 'Today' ? _todayBookings : _tomorrowBookings;

    return Scaffold(
      backgroundColor: AppColors.ivory,
      appBar: AppBar(
        backgroundColor: AppColors.ivory,
        foregroundColor: AppColors.forest,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          'Pickup slots',
          style: TextStyle(fontSize: 13),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Text(
              'Room for\nanother good order.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Demo bookings · Plan your pickup capacity.',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF75746E),
              ),
            ),
            const SizedBox(height: 22),
            Wrap(
              spacing: 8,
              children: ['Today', 'Tomorrow'].map((day) {
                return ChoiceChip(
                  label: Text(day),
                  selected: _day == day,
                  showCheckmark: false,
                  selectedColor: AppColors.forest,
                  backgroundColor: AppColors.ivory,
                  labelStyle: TextStyle(
                    color: _day == day
                        ? Colors.white
                        : AppColors.forest,
                  ),
                  onSelected: (_) {
                    setState(() => _day = day);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            ...List.generate(_times.length, (index) {
              final booked = bookings[index];
              final full = booked >= _capacity;

              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(18),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _times[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.ink,
                          ),
                        ),
                        Text(
                          full ? 'Full' : '${_capacity - booked} available',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.forest,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '$booked / $_capacity orders',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF75746E),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: booked / _capacity,
                        minHeight: 6,
                        backgroundColor: const Color(0xFFEAF0DE),
                        color: AppColors.forest,
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 10),
            const Text(
              'Each pickup slot is 15 minutes.',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF75746E),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _editSettings,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.forest,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text('Edit pickup settings'),
            ),
          ],
        ),
      ),
    );
  }
}