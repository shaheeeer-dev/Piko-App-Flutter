import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piko/customer/auth/signup_screen.dart';
import 'package:piko/customer/auth/widgets/auth_text_field.dart';
import 'package:piko/customer/auth/widgets/social_login_button.dart';
import 'package:piko/customer/home/home_screen.dart';
import 'package:piko/shared/theme/app_colors.dart';
import 'package:piko/shared/widgets/piko_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
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

              // Top Bar: Back Button & 'Log in' title
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
                    'Log in',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ink,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 36),

              // Logo & Brand Name Row with (R)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/piko_logo.svg',
                    height: 36,
                    width: 36,
                  ),
                  const SizedBox(width: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'piko',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 34,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1.2,
                          color: AppColors.ink,
                          height: 1.0,
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(3, -2),
                        child: const Text(
                          '®',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.ink,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // Welcome Back Heading
              const Text(
                'Welcome back.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.0,
                  color: AppColors.ink,
                ),
              ),

              const SizedBox(height: 8),

              // Subtext
              const Text(
                'Your usual is waiting for you.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF7A7974),
                ),
              ),

              const SizedBox(height: 32),

              // Email Field
              AuthTextField(
                label: 'Email',
                hintText: 'ayesha@example.com',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),

              // Password Field
              AuthTextField(
                label: 'Password',
                hintText: '••••••••',
                controller: _passwordController,
                obscureText: true,
              ),

              const SizedBox(height: 12),

              // Forgot Password link
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // Navigate to forgot password screen
                  },
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ink,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Log In Button
              PrimaryButton(
                text: 'Log in',
                onPressed: () {
                  // Handle login
                },
              ),

              const SizedBox(height: 24),

              // "or" Divider
              Row(
                children: const [
                  Expanded(
                    child: Divider(color: Color(0xFFE5E2DA), thickness: 1),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'or',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF9E9E98),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: Color(0xFFE5E2DA), thickness: 1),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Continue with Apple Button
              SocialLoginButton(
                text: 'Continue with Apple',
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

              // New to Piko? Create an account
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'New to Piko? ',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF7A7974),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Create an account',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.ink,
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
