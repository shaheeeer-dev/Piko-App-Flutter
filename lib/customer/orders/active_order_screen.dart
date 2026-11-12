import 'package:flutter/material.dart';
import 'package:piko/customer/orders/pickup_code_screen.dart';
import 'package:piko/shared/theme/app_colors.dart';
import 'package:piko/shared/widgets/piko_button.dart';

class ActiveOrderScreen extends StatefulWidget {
  final String orderId;
  final String restaurantName;
  final String restaurantLocation;
  final String pickupTime;
  final int totalItems;
  final int totalPrice;
  final List<Map<String, dynamic>>? items;

  const ActiveOrderScreen({
    super.key,
    this.orderId = '1042',
    this.restaurantName = 'June Coffee',
    this.restaurantLocation = '24 Main Boulevard, Gulberg',
    this.pickupTime = '12:30 PM',
    this.totalItems = 2,
    this.totalPrice = 1120,
    this.items,
  });

  @override
  State<ActiveOrderScreen> createState() => _ActiveOrderScreenState();
}

class _ActiveOrderScreenState extends State<ActiveOrderScreen> {
  String _formatCurrency(int amount) {
    final str = amount.toString();
    if (str.length <= 3) return str;
    return '${str.substring(0, str.length - 3)},${str.substring(str.length - 3)}';
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

              const SizedBox(height: 20),

              // Status Pill Badge ("In progress")
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EFDB),
                  borderRadius: BorderRadius.circular(8.68),
                ),
                child: const Text(
                  'In progress',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.forest,
                    letterSpacing: -0.2,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Headline: "Good things\nare brewing." (Figma Article-13)
              const Text(
                'Good things\nare brewing.',
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

              Text(
                'Your pickup is scheduled for ${widget.pickupTime}.',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subtext,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 28),

              // Live Status Timeline Stepper
              _buildTimelineStepper(),

              const SizedBox(height: 28),

              // Café Location Card
              _buildCafeCard(),

              const SizedBox(height: 16),

              // Order Summary Card
              _buildOrderSummaryCard(),

              const SizedBox(height: 20),

              // Secondary Button: "Contact café"
              _buildContactCafeButton(),

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
            text: 'View pickup code',
            trailing: const Icon(
              Icons.arrow_forward_rounded,
              color: AppColors.lime,
              size: 20,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PickupCodeScreen(
                    orderId: widget.orderId,
                    restaurantName: widget.restaurantName,
                    restaurantLocation: widget.restaurantLocation,
                    pickupTime: widget.pickupTime,
                    totalPrice: widget.totalPrice,
                    items: widget.items,
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
                'Live order status',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.muted,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _buildTimelineStepper() {
    return Column(
      children: [
        // Step 1: Order accepted (Completed)
        _buildTimelineItem(
          title: 'Order accepted',
          subtitle: "12:16 PM • We're on it.",
          isCompleted: true,
          isActive: false,
          showConnector: true,
        ),

        // Step 2: Being prepared (Active)
        _buildTimelineItem(
          title: 'Being prepared',
          subtitle: 'Your barista is making your order.',
          isCompleted: false,
          isActive: true,
          showConnector: true,
        ),

        // Step 3: Ready for pickup (Pending)
        _buildTimelineItem(
          title: 'Ready for pickup',
          subtitle: "We'll send you a notification.",
          isCompleted: false,
          isActive: false,
          showConnector: false,
        ),
      ],
    );
  }

  Widget _buildTimelineItem({
    required String title,
    required String subtitle,
    required bool isCompleted,
    required bool isActive,
    required bool showConnector,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column: Circle Icon + Connecting Line
        Column(
          children: [
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: (isCompleted || isActive)
                    ? AppColors.forest
                    : const Color(0xFFE9EDE2),
                shape: BoxShape.circle,
                border: Border.all(
                  color: (isCompleted || isActive)
                      ? AppColors.forest
                      : const Color(0xFFDCE2D6),
                  width: 1.2,
                ),
              ),
              child: isCompleted
                  ? const Icon(
                      Icons.check_rounded,
                      size: 14,
                      color: AppColors.ivory,
                    )
                  : (isActive
                      ? const Icon(
                          Icons.coffee_rounded,
                          size: 13,
                          color: AppColors.lime,
                        )
                      : const Icon(
                          Icons.circle,
                          size: 6,
                          color: AppColors.muted,
                        )),
            ),
            if (showConnector)
              Container(
                width: 2,
                height: 28,
                color: isCompleted
                    ? AppColors.forest
                    : const Color(0xFFDCE2D6),
              ),
          ],
        ),

        const SizedBox(width: 14),

        // Right Column: Title and Subtitle
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: (isCompleted || isActive)
                        ? FontWeight.w700
                        : FontWeight.w600,
                    color: (isCompleted || isActive)
                        ? AppColors.ink
                        : AppColors.subtext,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: isActive ? AppColors.ink : AppColors.subtext,
                  ),
                ),
                if (showConnector) const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCafeCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFEFA),
        borderRadius: BorderRadius.circular(16.5),
        border: Border.all(color: const Color(0xFFE5E7DE), width: 1.2),
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
              Icons.storefront_outlined,
              color: AppColors.forest,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.restaurantName,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: AppColors.ink,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.restaurantLocation,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: AppColors.subtext,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummaryCard() {
    return InkWell(
      onTap: _showOrderDetailsModal,
      borderRadius: BorderRadius.circular(16.5),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFEFA),
          borderRadius: BorderRadius.circular(16.5),
          border: Border.all(color: const Color(0xFFE5E7DE), width: 1.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order #${widget.orderId}',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${widget.totalItems} items • Paid Rs. ${_formatCurrency(widget.totalPrice)}',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.subtext,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.muted,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCafeButton() {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: OutlinedButton(
        onPressed: _showContactCafeModal,
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFFEEF0E8),
          side: const BorderSide(color: Color(0xFFDCE2D6), width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.5),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.phone_outlined,
              size: 16,
              color: AppColors.ink,
            ),
            SizedBox(width: 8),
            Text(
              'Contact café',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: AppColors.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOrderDetailsModal() {
    final displayItems = widget.items ??
        [
          {
            'title': 'Honey oat latte',
            'subtitle': 'Oat milk • a little sweetness',
            'price': 650,
          },
          {
            'title': 'Butter croissant',
            'subtitle': '1 item',
            'price': 420,
          },
        ];

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
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
                  'Order #${widget.orderId} Details',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 16),
                for (var item in displayItems) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'] as String? ?? '',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.ink,
                              ),
                            ),
                            Text(
                              item['subtitle'] as String? ?? '',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                color: AppColors.subtext,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Rs. ${_formatCurrency(item['price'] as int? ?? 0)}',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.ink,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: AppColors.line, height: 1),
                ],
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Paid',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink,
                      ),
                    ),
                    Text(
                      'Rs. ${_formatCurrency(widget.totalPrice)}',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.forest,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  text: 'Close',
                  onPressed: () => Navigator.pop(sheetContext),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showContactCafeModal() {
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
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: AppColors.line,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Container(
                  width: 54,
                  height: 54,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEDF1E7),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.phone_rounded,
                    color: AppColors.forest,
                    size: 26,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  widget.restaurantName,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  '+92 42 3578 9012',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: AppColors.subtext,
                  ),
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  text: 'Call café',
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Dialing ${widget.restaurantName}...'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

