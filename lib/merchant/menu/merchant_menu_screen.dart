import 'package:flutter/material.dart';
import 'package:piko/shared/theme/app_colors.dart';
import 'merchant_availability_screen.dart';
class MerchantMenuScreen extends StatefulWidget {
  const MerchantMenuScreen({super.key});

  @override
  State<MerchantMenuScreen> createState() => _MerchantMenuScreenState();
}

class _MerchantMenuScreenState extends State<MerchantMenuScreen> {
  String _selectedCategory = 'All';

  // Demo data: resets when the app restarts.
  static final List<_MenuItem> _items = [
    _MenuItem(name: 'Honey oat latte', category: 'Coffee', price: 650),
    _MenuItem(name: 'Butter croissant', category: 'Bakery', price: 470),
    _MenuItem(name: 'Iced mocha', category: 'Coffee', price: 700),
  ];

  Future<void> _openForm({_MenuItem? item}) async {
    final result = await Navigator.push<_MenuItem>(
      context,
      MaterialPageRoute(
        builder: (_) => _MerchantItemFormScreen(item: item),
      ),
    );

    if (!mounted || result == null) return;

    setState(() {
      if (item == null) {
        _items.add(result);
      } else {
        final index = _items.indexOf(item);
        if (index != -1) _items[index] = result;
      }
      _selectedCategory = 'All';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(item == null ? 'Item added.' : 'Item updated.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visibleItems = _items.where((item) {
      return _selectedCategory == 'All' ||
          item.category == _selectedCategory;
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
          'Menu & categories',
          style: TextStyle(fontSize: 13),
        ),
        actions: [
          IconButton(
            tooltip: 'Availability',
            icon: const Icon(Icons.tune),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MerchantAvailabilityScreen(
                    items: _items.map((item) {
                      return <String, dynamic>{
                        'name': item.name,
                        'available': item.available,
                      };
                    }).toList(),
                    onChanged: (index, available) {
                      if (!mounted) return;

                      setState(() {
                        _items[index].available = available;
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        backgroundColor: AppColors.forest,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add item'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
          children: [
            const Text(
              'Your menu',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'A little something for every day.',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF75746E),
              ),
            ),
            const SizedBox(height: 22),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['All', 'Coffee', 'Bakery'].map((category) {
                final selected = _selectedCategory == category;

                return ChoiceChip(
                  label: Text(category),
                  selected: selected,
                  showCheckmark: false,
                  selectedColor: AppColors.forest,
                  backgroundColor: AppColors.ivory,
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : AppColors.forest,
                  ),
                  onSelected: (_) {
                    setState(() => _selectedCategory = category);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            if (visibleItems.isEmpty)
              const Padding(
                padding: EdgeInsets.all(24),
                child: Text('No items in this category.'),
              ),
            ...visibleItems.map((item) {
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFFE0E4D9),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEAF0DE),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            item.category == 'Coffee'
                                ? Icons.local_cafe_outlined
                                : Icons.bakery_dining_outlined,
                            color: AppColors.forest,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.ink,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                item.category,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF75746E),
                                ),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                'Rs. ${item.price}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.forest,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          tooltip: 'Edit item',
                          onPressed: () => _openForm(item: item),
                          icon: const Icon(
                            Icons.edit_outlined,
                            color: AppColors.forest,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(color: Color(0xFFE0E4D9)),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.available
                                ? 'Available for orders'
                                : 'Currently unavailable',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.ink,
                            ),
                          ),
                        ),
                        Switch(
                          value: item.available,
                          activeTrackColor: AppColors.forest,
                          onChanged: (value) {
                            setState(() => item.available = value);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
            const Text(
              'Turn an item off when it is sold out.',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF75746E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem {
  final String name;
  final String category;
  final int price;
  bool available;

  _MenuItem({
    required this.name,
    required this.category,
    required this.price,
    this.available = true,
  });
}

class _MerchantItemFormScreen extends StatefulWidget {
  final _MenuItem? item;

  const _MerchantItemFormScreen({this.item});

  @override
  State<_MerchantItemFormScreen> createState() =>
      _MerchantItemFormScreenState();
}

class _MerchantItemFormScreenState
    extends State<_MerchantItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late String _category;
  late bool _available;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.item?.name ?? '',
    );
    _priceController = TextEditingController(
      text: widget.item?.price.toString() ?? '',
    );
    _category = widget.item?.category ?? 'Coffee';
    _available = widget.item?.available ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pop(
      context,
      _MenuItem(
        name: _nameController.text.trim(),
        category: _category,
        price: int.parse(_priceController.text.trim()),
        available: _available,
      ),
    );
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
    final editing = widget.item != null;

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
                child: Text(
                  editing ? 'Save changes' : 'Save menu item',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}