import 'package:flutter/material.dart';
import 'package:piko/customer/auth/forgot_password_screen.dart';
import 'package:piko/customer/auth/login_screen.dart';
import 'package:piko/customer/auth/signup_screen.dart';
import 'package:piko/customer/home/home_screen.dart';
import 'package:piko/customer/restaurant/item_detail_screen.dart';
import 'package:piko/customer/restaurant/menu_screen.dart';
import 'package:piko/customer/restaurant/restaurant_detail_screen.dart';
import 'package:piko/customer/splash/onboarding_s1.dart';

class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String restaurantDetail = '/restaurant-detail';
  static const String menu = '/menu';
  static const String itemDetail = '/item-detail';

  static Map<String, WidgetBuilder> get routes => {
        onboarding: (context) => const OnboardingS1(),
        login: (context) => const LoginScreen(),
        signup: (context) => const SignupScreen(),
        forgotPassword: (context) => const ForgotPasswordScreen(),
        home: (context) => const HomeScreen(),
        restaurantDetail: (context) => const RestaurantDetailScreen(),
        menu: (context) => const MenuScreen(),
        itemDetail: (context) => const ItemDetailScreen(),
      };
}
