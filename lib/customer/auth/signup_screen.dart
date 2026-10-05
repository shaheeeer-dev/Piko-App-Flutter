import 'package:flutter/material.dart';
import 'package:piko/customer/auth/widgets/auth_text_field.dart';
import 'package:piko/customer/home/home_screen.dart';
import 'package:piko/shared/theme/app_colors.dart';
import 'package:piko/shared/widgets/piko_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ivory,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              // Top Bar: Back Button & 'Sign up' title
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(
                        Icons.chevron_left_rounded,
                        size: 28,
                        color: AppColors.ink,
                      ),
                      onPressed: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                  const Text(
                    'Sign up',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ink,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Heading: "Your daily good\nstarts here."
              const Text(
                'Your daily good\nstarts here.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.2,
                  height: 1.12,
                  color: AppColors.ink,
                ),
              ),

              const SizedBox(height: 10),

              // Subtext: "Create your Piko account."
              const Text(
                'Create your Piko account.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF7A7974),
                ),
              ),

              const SizedBox(height: 28),

              // Full name field
              AuthTextField(
                label: 'Full name',
                hintText: 'Ayesha Khan',
                controller: _fullNameController,
                keyboardType: TextInputType.name,
              ),

              const SizedBox(height: 18),

              // Email field
              AuthTextField(
                label: 'Email',
                hintText: 'ayesha@example.com',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 18),

              // Phone number field
              AuthTextField(
                label: 'Phone number',
                hintText: '+92 3xx xxx xxxx',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 18),

              // Password field
              AuthTextField(
                label: 'Password',
                hintText: 'Create a strong password',
                controller: _passwordController,
                obscureText: true,
              ),

              const SizedBox(height: 20),

              // Terms and Privacy Policy notice
              const Text(
                'By joining, you agree to our Terms of Service and Privacy Policy.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                  color: Color(0xFF7A7974),
                ),
              ),

              const SizedBox(height: 32),

              // Create account Button
              PrimaryButton(
                text: 'Create account',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              // Already a member? Log in
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Already a member? ',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF7A7974),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.forest,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
