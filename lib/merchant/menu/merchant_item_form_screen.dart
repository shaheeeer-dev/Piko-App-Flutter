import 'package:flutter/material.dart';
import 'package:piko/shared/theme/app_colors.dart';

class MerchantItemFormScreen extends StatefulWidget {
  final String? name;
  final String category;
  final int? price;
  final bool available;

  const MerchantItemFormScreen({
    super.key,
    this.name,
    this.category = 'Coffee',
    this.price,
    this.available = true,
  });

  @override
  State<MerchantItemFormScreen> createState() =>
      _MerchantItemFormScreenState();
}

class _MerchantItemFormScreenState
    extends State<MerchantItemFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late String _category;
  late bool _available;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name ?? '');
    _priceController = TextEditingController(
      text: widget.price?.toString() ?? '',
    );
    _category = widget.category;
    _available = widget.available;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pop<Map<String, dynamic>>(context, {
      'name': _nameController.text.trim(),
      'category': _category,
      'price': int.parse(_priceController.text.trim()),
      'available': _available,
    });
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFE0E4D9)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.forest),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.name != null;

    return Scaffold(
      backgroundColor: AppColors.ivory,
      appBar: AppBar(
        backgroundColor: AppColors.ivory,
        foregroundColor: AppColors.forest,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          editing ? 'Edit item' : 'Add item',
          style: const TextStyle(fontSize: 13),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Text(
                editing ? 'Make it yours.' : 'Something delicious.',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Every little detail matters.',
                style: TextStyle(color: Color(0xFF75746E)),
              ),
              const SizedBox(height: 28),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF0DE),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  _category == 'Coffee'
                      ? Icons.local_cafe_outlined
                      : Icons.bakery_dining_outlined,
                  size: 48,
                  color: AppColors.forest,
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
                decoration: _decoration('Item name'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter an item name.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: _decoration('Price in Rs.'),
                validator: (value) {
                  final price = int.tryParse(value?.trim() ?? '');
                  if (price == null || price <= 0) {
                    return 'Enter a positive whole-number price.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'Category',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: ['Coffee', 'Bakery'].map((category) {
                  final selected = _category == category;
                  return ChoiceChip(
                    label: Text(category),
                    selected: selected,
                    showCheckmark: false,
                    selectedColor: AppColors.forest,
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : AppColors.forest,
                    ),
                    onSelected: (_) {
                      setState(() => _category = category);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'Available for orders',
                  style: TextStyle(fontSize: 14),
                ),
                value: _available,
                activeTrackColor: AppColors.forest,
                onChanged: (value) {
                  setState(() => _available = value);
                },
              ),
              const SizedBox(height: 28),
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
                child: Text(editing ? 'Save changes' : 'Save menu item'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}