import 'package:flutter/material.dart';
import 'business_details_screen.dart';
import 'package:piko/shared/theme/app_colors.dart';
import 'package:piko/shared/widgets/piko_button.dart';

class BusinessSetupScreen extends StatefulWidget {
  const BusinessSetupScreen({super.key});

  @override
  State<BusinessSetupScreen> createState() => _BusinessSetupScreenState();
}

class _BusinessSetupScreenState extends State<BusinessSetupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _continue() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BusinessDetailsScreen(
          businessName: _nameController.text.trim(),
          category: _categoryController.text.trim(),
          address: _addressController.text.trim(),
          phone: _phoneController.text.trim(),
          email: _emailController.text.trim(),
        ),
      ),
    );
  }

  Widget _field({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    bool lastField = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            textInputAction:
            lastField ? TextInputAction.done : TextInputAction.next,
            onFieldSubmitted: lastField ? (_) => _continue() : null,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.ink,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                fontSize: 13,
                color: Color(0xFF75746E),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFFE0E4D9),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: AppColors.forest,
                  width: 1.5,
                ),
              ),
            ),
            validator: validator ??
                    (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter ${label.toLowerCase()}.';
                  }
                  return null;
                },
          ),
        ],
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
          'Business setup',
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
                    'Step 1 of 2',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: AppColors.forest,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Meet your\nnew regulars.',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 28,
                    height: 1.15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Start with the basics about your business.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Color(0xFF75746E),
                  ),
                ),
                const SizedBox(height: 26),

                _field(
                  label: 'Business name',
                  hint: 'June Coffee',
                  controller: _nameController,
                ),
                _field(
                  label: 'Category',
                  hint: 'Coffee & bakery',
                  controller: _categoryController,
                ),
                _field(
                  label: 'Business address',
                  hint: '24 Main Boulevard, Gulberg',
                  controller: _addressController,
                  keyboardType: TextInputType.streetAddress,
                ),
                _field(
                  label: 'Contact number',
                  hint: '+92 42 3456 7890',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    final phone = value?.trim() ?? '';

                    if (phone.isEmpty) {
                      return 'Please enter your contact number.';
                    }

                    final digits = phone.replaceAll(RegExp(r'\D'), '');

                    if (!RegExp(r'^\+?[\d\s()\-]+$').hasMatch(phone) ||
                        digits.length < 10 ||
                        digits.length > 15) {
                      return 'Please enter a valid phone number.';
                    }

                    return null;
                  },
                ),
                _field(
                  label: 'Business email',
                  hint: 'hello@junecoffee.example',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  lastField: true,
                  validator: (value) {
                    final email = value?.trim() ?? '';

                    if (email.isEmpty) {
                      return 'Please enter your business email.';
                    }

                    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                        .hasMatch(email)) {
                      return 'Please enter a valid email.';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 12),
                PrimaryButton(
                  text: 'Continue',
                  onPressed: _continue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}