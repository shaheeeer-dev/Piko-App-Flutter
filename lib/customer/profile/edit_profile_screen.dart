import 'package:flutter/material.dart';
import 'package:piko/shared/theme/app_colors.dart';
import 'package:piko/shared/widgets/piko_button.dart';

class EditProfileScreen extends StatefulWidget {
  final String initialName;
  final String initialEmail;
  final String initialPhone;
  final String initialNeighborhood;
  final void Function(String name, String email, String phone, String neighborhood)? onSave;

  const EditProfileScreen({
    super.key,
    this.initialName = 'Ayesha Khan',
    this.initialEmail = 'ayesha@example.com',
    this.initialPhone = '+92 300 123 4567',
    this.initialNeighborhood = 'Gulberg, Lahore',
    this.onSave,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _neighborhoodController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _emailController = TextEditingController(text: widget.initialEmail);
    _phoneController = TextEditingController(text: widget.initialPhone);
    _neighborhoodController =
        TextEditingController(text: widget.initialNeighborhood);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _neighborhoodController.dispose();
    super.dispose();
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

              const SizedBox(height: 18),

              // Title & Subtitle (Figma Article-19)
              const Text(
                'Make yourself\nat home.',
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
                'Your account details.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                  color: AppColors.subtext,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 24),

              // Avatar with Initials
              Center(
                child: Container(
                  width: 68,
                  height: 68,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE5EBD8),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    _getInitials(_nameController.text),
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.forest,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Input: Full name
              _buildInputLabel('Full name'),
              const SizedBox(height: 6),
              _buildTextField(_nameController, 'Your full name'),

              const SizedBox(height: 18),

              // Input: Email
              _buildInputLabel('Email'),
              const SizedBox(height: 6),
              _buildTextField(_emailController, 'Your email address',
                  keyboardType: TextInputType.emailAddress),

              const SizedBox(height: 18),

              // Input: Phone number
              _buildInputLabel('Phone number'),
              const SizedBox(height: 6),
              _buildTextField(_phoneController, '+92 300 000 0000',
                  keyboardType: TextInputType.phone),

              const SizedBox(height: 18),

              // Input: Default neighborhood
              _buildInputLabel('Default neighborhood'),
              const SizedBox(height: 6),
              _buildTextField(_neighborhoodController, 'Gulberg, Lahore'),

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
            text: 'Save changes',
            trailing: const Icon(
              Icons.arrow_forward_rounded,
              color: AppColors.lime,
              size: 20,
            ),
            onPressed: () {
              if (widget.onSave != null) {
                widget.onSave!(
                  _nameController.text.trim(),
                  _emailController.text.trim(),
                  _phoneController.text.trim(),
                  _neighborhoodController.text.trim(),
                );
              }
              Navigator.pop(context, {
                'name': _nameController.text.trim(),
                'email': _emailController.text.trim(),
                'phone': _phoneController.text.trim(),
                'neighborhood': _neighborhoodController.text.trim(),
              });
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
            onPressed: () => Navigator.of(context).maybePop(),
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
                'Edit profile',
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
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
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
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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

  String _getInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts[0].isEmpty) return 'AK';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
}

