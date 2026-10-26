import 'package:flutter/material.dart';
import 'package:piko/shared/theme/app_colors.dart';
import 'package:piko/shared/widgets/piko_button.dart';

class PickupTimeScreen extends StatefulWidget {
  final String restaurantName;
  final String openHours;
  final int totalItems;
  final int totalPrice;

  const PickupTimeScreen({
    super.key,
    this.restaurantName = 'June Coffee',
    this.openHours = 'Open until 8 PM',
    this.totalItems = 2,
    this.totalPrice = 1120,
  });

  @override
  State<PickupTimeScreen> createState() => _PickupTimeScreenState();
}

class _PickupTimeScreenState extends State<PickupTimeScreen> {
  // Selection mode: true if ASAP, false if specific slot
  bool _isAsap = false;
  int _selectedDayIndex = 0; // 0: Today, 1: Tomorrow
  int _selectedSlotIndex = 0; // Index of the chosen time slot

  final List<String> _days = ['Today, Oct 3', 'Tomorrow'];

  final List<String> _timeSlots = [
    '12:30 PM',
    '12:45 PM',
    '1:00 PM',
    '1:15 PM',
    '1:30 PM',
    '1:45 PM',
  ];

  String get _selectedTimeLabel {
    if (_isAsap) {
      return 'ASAP';
    }
    return _timeSlots[_selectedSlotIndex];
  }

  @override
  Widget build(BuildContext context) {
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

              const SizedBox(height: 22),

              // Headline: "When works\nfor you?"
              const Text(
                'When works\nfor you?',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 29,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                  letterSpacing: -1.0,
                  height: 1.05,
                ),
              ),

              const SizedBox(height: 6),

              // Subtitle: "June Coffee • Open until 8 PM"
              Text(
                '${widget.restaurantName} • ${widget.openHours}',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.subtext,
                ),
              ),

              const SizedBox(height: 22),

              // "As soon as possible" Option Card
              _buildAsapCard(),

              const SizedBox(height: 26),

              // Section Header: "Or choose a time"
              const Text(
                'Or choose a time',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                  letterSpacing: -0.3,
                ),
              ),

              const SizedBox(height: 14),

              // Day Selector Tabs ("Today, Oct 3", "Tomorrow")
              _buildDayTabs(),

              const SizedBox(height: 16),

              // 2-Column Time Slots Grid
              _buildTimeSlotsGrid(),

              const SizedBox(height: 18),

              // Helper / Story Note
              const Text(
                'Pickup slots help the café prepare your order at just the right time.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subtext,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 8, 28, 16),
          child: PrimaryButton(
            text: 'Confirm • $_selectedTimeLabel',
            trailing: const Icon(
              Icons.arrow_forward_rounded,
              color: AppColors.lime,
              size: 20,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 2),
                  content: Text(
                    'Pickup time confirmed: $_selectedTimeLabel for ${widget.restaurantName}',
                  ),
                ),
              );
            },
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
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
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
                'Pickup time',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.muted,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16), // Symmetry balance
        ],
      ),
    );
  }

  Widget _buildAsapCard() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isAsap = true;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _isAsap ? const Color(0xFFEDF3E4) : const Color(0xFFFFFEFA),
          borderRadius: BorderRadius.circular(16.5),
          border: Border.all(
            color: _isAsap ? AppColors.forest : const Color(0xFFE5E7DE),
            width: _isAsap ? 1.4 : 1.2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFEDF1E7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.bolt_rounded,
                color: AppColors.forest,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'As soon as possible',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: AppColors.ink,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Ready in approximately 10–15 minutes.',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: AppColors.subtext,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            if (_isAsap)
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.forest,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayTabs() {
    return Row(
      children: List.generate(_days.length, (index) {
        final isSelected = !_isAsap && _selectedDayIndex == index;
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isAsap = false;
                _selectedDayIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.forest : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? AppColors.forest : const Color(0xFFDFE4D9),
                  width: 1.2,
                ),
              ),
              child: Text(
                _days[index],
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? AppColors.ivory : AppColors.subtext,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTimeSlotsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _timeSlots.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.3,
      ),
      itemBuilder: (context, index) {
        final slot = _timeSlots[index];
        final isSelected = !_isAsap && _selectedSlotIndex == index;

        return GestureDetector(
          onTap: () {
            setState(() {
              _isAsap = false;
              _selectedSlotIndex = index;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFFEDF3E4)
                  : const Color(0xFFFFFEFB),
              borderRadius: BorderRadius.circular(11.5),
              border: Border.all(
                color: isSelected
                    ? AppColors.forest
                    : const Color(0xFFDCE2D5),
                width: isSelected ? 1.4 : 1.1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  slot,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? AppColors.forest : AppColors.ink,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  isSelected ? 'Selected' : 'Available',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected
                        ? const Color(0xFF47684C)
                        : AppColors.subtext,
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
