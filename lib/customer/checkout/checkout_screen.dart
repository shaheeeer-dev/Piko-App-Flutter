import 'package:flutter/material.dart';
import 'package:piko/customer/checkout/order_success_screen.dart';
import 'package:piko/shared/theme/app_colors.dart';
import 'package:piko/shared/widgets/piko_button.dart';

enum PaymentType { card, cash }

class PaymentMethodOption {
  final String id;
  final String title;
  final String subtitle;
  final PaymentType type;

  const PaymentMethodOption({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
  });
}

class CheckoutScreen extends StatefulWidget {
  final String restaurantName;
  final String restaurantLocation;
  final String pickupTimeLabel;
  final int subtotal;
  final int serviceFee;
  final int totalPrice;
  final int totalItems;
  final List<Map<String, dynamic>>? items;

  const CheckoutScreen({
    super.key,
    this.restaurantName = 'June Coffee',
    this.restaurantLocation = 'Gulberg',
    this.pickupTimeLabel = 'Today • 12:30 PM',
    this.subtotal = 1070,
    this.serviceFee = 50,
    this.totalPrice = 1120,
    this.totalItems = 2,
    this.items,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _customerName = 'Ayesha Khan';
  String _customerPhone = '+92 300 123 4567';

  late List<PaymentMethodOption> _paymentMethods;
  String _selectedPaymentId = 'visa_4242';
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _paymentMethods = [
      const PaymentMethodOption(
        id: 'visa_4242',
        title: 'Visa ending in 4242',
        subtitle: 'Expires 08/28',
        type: PaymentType.card,
      ),
      const PaymentMethodOption(
        id: 'cash_pickup',
        title: 'Pay at pickup',
        subtitle: 'Cash at the counter',
        type: PaymentType.cash,
      ),
    ];
  }

  int get _computedTotal {
    if (widget.totalPrice > 0) return widget.totalPrice;
    return widget.subtotal + widget.serviceFee;
  }

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

              const SizedBox(height: 22),

              // Headline & Subtitle (Figma: "One last thing." / "Check your details, then you're all set.")
              const Text(
                'One last thing.',
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
                "Check your details, then you're all set.",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subtext,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 24),

              // Pickup Location & Time Card
              _buildPickupCard(),

              const SizedBox(height: 24),

              // Customer Details (Name, Phone, Edit action)
              _buildCustomerDetails(),

              const SizedBox(height: 28),

              // Payment Method Section
              _buildPaymentSection(),

              const SizedBox(height: 28),

              // Price Breakdown (Subtotal, Service fee, Total)
              _buildPriceBreakdown(),

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
            text: _isProcessing
                ? 'Processing...'
                : 'Pay Rs. ${_formatCurrency(_computedTotal)}',
            trailing: _isProcessing
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.lime),
                    ),
                  )
                : const Icon(
                    Icons.arrow_forward_rounded,
                    color: AppColors.lime,
                    size: 20,
                  ),
            onPressed: _isProcessing ? () {} : _handlePayment,
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
                'Checkout & payment',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.muted,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16), // Balance back button
        ],
      ),
    );
  }

  Widget _buildPickupCard() {
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
                  widget.pickupTimeLabel,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: AppColors.ink,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${widget.restaurantName}, ${widget.restaurantLocation}',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: AppColors.subtext,
                    fontSize: 11.5,
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

  Widget _buildCustomerDetails() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _customerName,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _customerPhone,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w400,
                    color: AppColors.subtext,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: _showEditCustomerModal,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                'Edit',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.ink,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment method',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.ink,
          ),
        ),
        const SizedBox(height: 14),

        // List existing payment methods
        ..._paymentMethods.map((option) => _buildPaymentOptionTile(option)),

        // Add a card row
        _buildAddCardTile(),
      ],
    );
  }

  Widget _buildPaymentOptionTile(PaymentMethodOption option) {
    final isSelected = _selectedPaymentId == option.id;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedPaymentId = option.id;
          });
        },
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.title,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      option.subtitle,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.subtext,
                      ),
                    ),
                  ],
                ),
              ),
              // Custom Radio Indicator (Outer ring + dot)
              Container(
                width: 18,
                height: 18,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.forest
                        : const Color(0xFFDCE2D5),
                    width: isSelected ? 1.5 : 1.2,
                  ),
                ),
                child: isSelected
                    ? Container(
                        width: 9,
                        height: 9,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.forest,
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddCardTile() {
    return InkWell(
      onTap: _showAddCardModal,
      borderRadius: BorderRadius.circular(10),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Add a card',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.ink,
                ),
              ),
            ),
            Icon(
              Icons.add_rounded,
              color: AppColors.ink,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceBreakdown() {
    return Column(
      children: [
        // Subtotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Subtotal',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.subtext,
              ),
            ),
            Text(
              'Rs. ${_formatCurrency(widget.subtotal)}',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.ink,
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // Service fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Service fee',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.subtext,
              ),
            ),
            Text(
              'Rs. ${_formatCurrency(widget.serviceFee)}',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.ink,
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        const Divider(color: Color(0xFFE5E7DE), thickness: 1, height: 1),

        const SizedBox(height: 14),

        // Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
                letterSpacing: -0.3,
              ),
            ),
            Text(
              'Rs. ${_formatCurrency(_computedTotal)}',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showEditCustomerModal() {
    final nameController = TextEditingController(text: _customerName);
    final phoneController = TextEditingController(text: _customerPhone);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: Container(
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
                  const Text(
                    'Contact details',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInputLabel('Full name'),
                  const SizedBox(height: 6),
                  _buildTextField(nameController, 'Your name'),
                  const SizedBox(height: 14),
                  _buildInputLabel('Phone number'),
                  const SizedBox(height: 6),
                  _buildTextField(phoneController, '+92 300 0000000',
                      keyboardType: TextInputType.phone),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    text: 'Save details',
                    onPressed: () {
                      if (nameController.text.trim().isNotEmpty) {
                        setState(() {
                          _customerName = nameController.text.trim();
                          _customerPhone = phoneController.text.trim();
                        });
                      }
                      Navigator.pop(sheetContext);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showAddCardModal() {
    final numberController = TextEditingController();
    final expiryController = TextEditingController();
    final cvvController = TextEditingController();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: Container(
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
                  const Text(
                    'Add a new card',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInputLabel('Card number'),
                  const SizedBox(height: 6),
                  _buildTextField(numberController, '4242 •••• •••• 4242',
                      keyboardType: TextInputType.number),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInputLabel('Expires'),
                            const SizedBox(height: 6),
                            _buildTextField(expiryController, 'MM/YY',
                                keyboardType: TextInputType.datetime),
                          ],
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInputLabel('CVV'),
                            const SizedBox(height: 6),
                            _buildTextField(cvvController, '123',
                                keyboardType: TextInputType.number,
                                obscureText: true),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    text: 'Save & use card',
                    onPressed: () {
                      final rawNumber = numberController.text.replaceAll(' ', '');
                      final last4 = rawNumber.length >= 4
                          ? rawNumber.substring(rawNumber.length - 4)
                          : '1234';
                      final expiry = expiryController.text.trim().isNotEmpty
                          ? expiryController.text.trim()
                          : '12/28';

                      final newOption = PaymentMethodOption(
                        id: 'card_${DateTime.now().millisecondsSinceEpoch}',
                        title: 'Card ending in $last4',
                        subtitle: 'Expires $expiry',
                        type: PaymentType.card,
                      );

                      setState(() {
                        _paymentMethods.insert(0, newOption);
                        _selectedPaymentId = newOption.id;
                      });

                      Navigator.pop(sheetContext);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 12.5,
        fontWeight: FontWeight.w600,
        color: AppColors.subtext,
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.ink,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.subtext,
        ),
        filled: true,
        fillColor: const Color(0xFFFFFEFA),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE5E7DE), width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.forest, width: 1.5),
        ),
      ),
    );
  }

  void _handlePayment() async {
    setState(() {
      _isProcessing = true;
    });

    // Provide a natural tactile feedback delay
    await Future.delayed(const Duration(milliseconds: 350));

    if (!mounted) return;

    setState(() {
      _isProcessing = false;
    });

    final selectedMethod = _paymentMethods.firstWhere(
      (m) => m.id == _selectedPaymentId,
      orElse: () => _paymentMethods.first,
    );

    final paymentSummary = selectedMethod.type == PaymentType.card
        ? 'Paid with ${selectedMethod.title.replaceFirst("ending in", "••••")}'
        : 'Paid with Cash at pickup';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderSuccessScreen(
          restaurantName: widget.restaurantName,
          restaurantLocation: widget.restaurantLocation,
          pickupTime: widget.pickupTimeLabel.replaceAll('Today • ', ''),
          paymentMethod: paymentSummary,
          totalPrice: _computedTotal,
          items: widget.items,
        ),
      ),
    );
  }
}
