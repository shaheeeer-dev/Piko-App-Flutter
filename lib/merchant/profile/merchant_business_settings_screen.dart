import 'package:flutter/material.dart';
import 'package:piko/shared/theme/app_colors.dart';

class MerchantBusinessSettingsScreen extends StatefulWidget {
  final Map<String, String> details;

  const MerchantBusinessSettingsScreen({
    super.key,
    required this.details,
  });

  @override
  State<MerchantBusinessSettingsScreen> createState() =>
      _MerchantBusinessSettingsScreenState();
}

class _MerchantBusinessSettingsScreenState
    extends State<MerchantBusinessSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};

  final Map<String, String> _labels = {
    'businessName': 'Business name',
    'category': 'Category',
    'address': 'Address',
    'phone': 'Phone',
    'email': 'Email',
    'openingHours': 'Opening hours',
    'preparationMinutes': 'Preparation time (minutes)',
    'slotMinutes': 'Pickup slot duration (minutes)',
    'ordersPerSlot': 'Orders per slot',
    'pickupInstructions': 'Pickup instructions',
  };

  bool _isNumber(String key) {
    return [
      'preparationMinutes',
      'slotMinutes',
      'ordersPerSlot',
    ].contains(key);
  }

  @override
  void initState() {
    super.initState();

    for (final key in _labels.keys) {
      _controllers[key] = TextEditingController(
        text: widget.details[key] ?? '',
      );
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final result = <String, String>{};

    for (final entry in _controllers.entries) {
      result[entry.key] = entry.value.text.trim();
    }

    Navigator.pop(context, result);
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
          'Business settings',
          style: TextStyle(fontSize: 13),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const Text(
                'Your business,\nyour way.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Update your business profile.',
                style: TextStyle(color: Color(0xFF75746E)),
              ),
              const SizedBox(height: 28),
              ..._labels.entries.map((entry) {
                final key = entry.key;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    controller: _controllers[key],
                    keyboardType: _isNumber(key)
                        ? TextInputType.number
                        : key == 'email'
                        ? TextInputType.emailAddress
                        : key == 'phone'
                        ? TextInputType.phone
                        : TextInputType.text,
                    maxLines: key == 'pickupInstructions' ? 3 : 1,
                    decoration: InputDecoration(
                      labelText: entry.value,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFFE0E4D9),
                        ),
                      ),
                    ),
                    validator: (value) {
                      final text = value?.trim() ?? '';

                      if (_isNumber(key)) {
                        final number = int.tryParse(text);
                        if (number == null || number <= 0) {
                          return 'Enter a positive whole number.';
                        }
                      } else if (key != 'phone' &&
                          key != 'pickupInstructions' &&
                          text.isEmpty) {
                        return 'Please enter ${entry.value.toLowerCase()}.';
                      }

                      if (key == 'email' &&
                          !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                              .hasMatch(text)) {
                        return 'Please enter a valid email.';
                      }

                      return null;
                    },
                  ),
                );
              }),
              ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.forest,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text('Save changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}