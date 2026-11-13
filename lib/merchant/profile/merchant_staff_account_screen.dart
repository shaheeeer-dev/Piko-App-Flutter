import 'package:flutter/material.dart';
import 'package:piko/shared/theme/app_colors.dart';
import 'merchant_logout_screen.dart';
import '../splash/merchant_welcome_screen.dart';
class MerchantStaffAccountScreen extends StatefulWidget {
  final String businessName;
  final String email;

  const MerchantStaffAccountScreen({
    super.key,
    required this.businessName,
    required this.email,
  });

  @override
  State<MerchantStaffAccountScreen> createState() =>
      _MerchantStaffAccountScreenState();
}

class _MerchantStaffAccountScreenState
    extends State<MerchantStaffAccountScreen> {
  // Demo staff: resets when the app restarts.
  static final List<Map<String, String>> _staff = [];

  Future<void> _addStaff() async {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();

    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Add demo staff'),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Staff name',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter a name.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    final email = value?.trim().toLowerCase() ?? '';

                    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                        .hasMatch(email)) {
                      return 'Enter a valid email.';
                    }

                    if (email == widget.email.trim().toLowerCase() ||
                        _staff.any((member) =>
                        member['email']!.toLowerCase() == email)) {
                      return 'This email is already listed.';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'This adds a local demo entry. No invitation is sent.',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (!formKey.currentState!.validate()) return;

              Navigator.pop(dialogContext, <String, String>{
                'name': nameController.text.trim(),
                'email': emailController.text.trim(),
              });
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );

    // Wait until the dialog's closing animation finishes before disposal.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      nameController.dispose();
      emailController.dispose();
    });

    if (!mounted || result == null) return;

    setState(() => _staff.add(result));
  }

  Future<void> _removeStaff(Map<String, String> member) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Remove staff member?'),
        content: Text('Remove ${member['name']} from the demo list?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );

    if (!mounted || confirmed != true) return;

    setState(() => _staff.remove(member));
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
        actions: [
          IconButton(
            tooltip: 'Log out',
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final confirmed = await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  builder: (_) => const MerchantLogoutScreen(),
                ),
              );

              if (!mounted || confirmed != true) return;

              Navigator.of(this.context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => MerchantWelcomeScreen(),
                ),
                    (route) => false,
              );
            },
          ),
        ],
        title: const Text(
          'Staff & account',
          style: TextStyle(fontSize: 13),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Text(
              'Behind every\ngood order.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Your account and demo team.',
              style: TextStyle(color: Color(0xFF75746E)),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF0DE),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.admin_panel_settings_outlined,
                    color: AppColors.forest,
                    size: 32,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.businessName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(widget.email),
                  const SizedBox(height: 8),
                  const Text(
                    'Owner · Demo account',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.forest,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Staff members (${_staff.length})',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 14),
            if (_staff.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text('No staff members added yet.'),
              ),
            ..._staff.map((member) {
              return Card(
                color: Colors.white,
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(
                    Icons.person_outline,
                    color: AppColors.forest,
                  ),
                  title: Text(member['name']!),
                  subtitle: Text(member['email']!),
                  trailing: IconButton(
                    tooltip: 'Remove staff member',
                    onPressed: () => _removeStaff(member),
                    icon: const Icon(Icons.delete_outline),
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _addStaff,
              icon: const Icon(Icons.person_add_alt),
              label: const Text('Add demo staff'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.forest,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}