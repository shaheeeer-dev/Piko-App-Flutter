import 'package:flutter/material.dart';
import '../dashboard/merchant_dashboard_screen.dart';
import 'package:piko/shared/theme/app_colors.dart';
import 'package:piko/shared/widgets/piko_button.dart';

class BusinessDetailsScreen extends StatefulWidget {
  final String businessName;
  final String category;
  final String address;
  final String phone;
  final String email;

  const BusinessDetailsScreen({
    super.key,
    required this.businessName,
    required this.category,
    required this.address,
    required this.phone,
    required this.email,
  });

  @override
  State<BusinessDetailsScreen> createState() =>
      _BusinessDetailsScreenState();
}

class _BusinessDetailsScreenState extends State<BusinessDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ordersController = TextEditingController(text: '8');
  final _instructionsController = TextEditingController();

  TimeOfDay _opening = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _closing = const TimeOfDay(hour: 20, minute: 0);

  int _preparationMinutes = 15;
  int _slotMinutes = 15;

  @override
  void dispose() {
    _ordersController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  Future<void> _pickTime(bool opening) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: opening ? _opening : _closing,
    );

    if (!mounted || selected == null) return;

    setState(() {
      if (opening) {
        _opening = selected;
      } else {
        _closing = selected;
      }
    });
  }

  void _openDashboard() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    if (_opening.hour == _closing.hour &&
        _opening.minute == _closing.minute) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Choose different opening and closing times.'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MerchantDashboardScreen(
          businessName: widget.businessName,
          category: widget.category,
          address: widget.address,
          phone: widget.phone,
          email: widget.email,
          openingHours:
          '${_opening.format(context)} – ${_closing.format(context)}',
          preparationMinutes: _preparationMinutes,
          slotMinutes: _slotMinutes,
          ordersPerSlot: int.parse(_ordersController.text.trim()),
          pickupInstructions: _instructionsController.text.trim(),
        ),
      ),
    );
  }

  InputDecoration _decoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: 13,
        color: Color(0xFF75746E),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 15,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFE0E4D9)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.forest,
          width: 1.5,
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.ink,
        ),
      ),
    );
  }

  Widget _timeButton({
    required String label,
    required TimeOfDay time,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.forest,
          padding: const EdgeInsets.symmetric(vertical: 14),
          side: const BorderSide(color: Color(0xFFE0E4D9)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Column(
          children: [
            Text(label, style: const TextStyle(fontSize: 11)),
            const SizedBox(height: 5),
            Text(
              time.format(context),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ivory,
      appBar: AppBar(
        backgroundColor: AppColors.ivory,
        foregroundColor: AppColors.forest,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          'Pickup setup',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF75746E),
          ),
        ),
        leading: IconButton(
          tooltip: 'Back',
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7EED9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Step 2 of 2',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.forest,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Set your pace.',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Keep pickup smooth for you and your customers.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Color(0xFF75746E),
                  ),
                ),
                const SizedBox(height: 26),

                _label('Opening hours'),
                Row(
                  children: [
                    _timeButton(
                      label: 'Opens',
                      time: _opening,
                      onTap: () => _pickTime(true),
                    ),
                    const SizedBox(width: 12),
                    _timeButton(
                      label: 'Closes',
                      time: _closing,
                      onTap: () => _pickTime(false),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                _label('Preparation time'),
                DropdownButtonFormField<int>(
                  initialValue: _preparationMinutes,
                  decoration: _decoration(),
                  isExpanded: true,
                  items: [5, 10, 15, 20, 30, 45, 60]
                      .map(
                        (minutes) => DropdownMenuItem(
                      value: minutes,
                      child: Text('$minutes minutes'),
                    ),
                  )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() => _preparationMinutes = value);
                  },
                ),
                const SizedBox(height: 18),

                _label('Pickup slot duration'),
                DropdownButtonFormField<int>(
                  initialValue: _slotMinutes,
                  decoration: _decoration(),
                  isExpanded: true,
                  items: [10, 15, 20, 30, 60]
                      .map(
                        (minutes) => DropdownMenuItem(
                      value: minutes,
                      child: Text('$minutes minutes'),
                    ),
                  )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() => _slotMinutes = value);
                  },
                ),
                const SizedBox(height: 18),

                _label('Orders per slot'),
                TextFormField(
                  controller: _ordersController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: _decoration(hint: '8'),
                  validator: (value) {
                    final orders = int.tryParse(value?.trim() ?? '');

                    if (orders == null || orders < 1) {
                      return 'Enter a whole number greater than zero.';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 18),

                _label('Pickup instructions'),
                TextFormField(
                  controller: _instructionsController,
                  minLines: 2,
                  maxLines: 3,
                  decoration: _decoration(
                    hint: 'Collect at the counter beside the entrance.',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter pickup instructions.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: const Color(0xFFE0E4D9),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.tune,
                        color: AppColors.forest,
                        size: 24,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "You're in control",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.ink,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Update these anytime in business settings.",
                              style: TextStyle(
                                fontSize: 11,
                                height: 1.4,
                                color: Color(0xFF75746E),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                PrimaryButton(
                  text: 'Open my dashboard',
                  onPressed: _openDashboard,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}