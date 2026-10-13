# Piko-App-Flutter

```
lib/
├── main.dart
├── app.dart
│
├── customer/
│   │
│   ├── splash/
│   │   ├── onboarding_s1.dart
│   │   └── onboarding_s2.dart
│   │ 
│   ├── auth/
│   │   ├── login_screen.dart
│   │   ├── signup_screen.dart
│   │   ├── forgot_password_screen.dart
│   │   └── widgets/
│   │       ├── auth_text_field.dart
│   │       └── social_login_button.dart
│   │
│   ├── home/
│   │   ├── home_screen.dart
│   │   ├── search_screen.dart
│   │   ├── offers_screen.dart
│   │   └── widgets/
│   │       ├── restaurant_card.dart
│   │       ├── category_chip.dart
│   │       └── offer_card.dart
│   │
│   ├── restaurant/
│   │   ├── restaurant_detail_screen.dart
│   │   ├── menu_screen.dart
│   │   ├── item_detail_screen.dart
│   │   └── widgets/
│   │       ├── menu_item_card.dart
│   │       ├── category_tab.dart
│   │       └── addon_tile.dart
│   │
│   ├── cart/
│   │   ├── cart_screen.dart
│   │   └── widgets/
│   │       ├── cart_item_tile.dart
│   │       └── order_summary.dart
│   │
│   ├── checkout/
│   │   ├── checkout_screen.dart
│   │   ├── pickup_time_screen.dart
│   │   ├── payment_screen.dart
│   │   └── order_success_screen.dart
│   │
│   ├── orders/
│   │   ├── orders_screen.dart
│   │   ├── active_order_screen.dart
│   │   ├── order_details_screen.dart
│   │   └── pickup_code_screen.dart
│   │
│   ├── rewards/
│   │   ├── rewards_screen.dart
│   │   └── offers_screen.dart
│   │
│   └── profile/
│       ├── profile_screen.dart
│       ├── edit_profile_screen.dart
│       ├── settings_screen.dart
│       ├── notifications_screen.dart
│       └── help_screen.dart
│
├── shared/
│   ├── widgets/
│   │   ├── piko_bottom_navigation.dart
│   │   ├── piko_button.dart
│   │   ├── piko_text_field.dart
│   │   ├── piko_app_bar.dart
│   │   ├── loading_widget.dart
│   │   └── empty_state.dart
│   │
│   ├── theme/
│   │   ├── app_colors.dart
│   │   ├── app_theme.dart
│   │   └── app_text_styles.dart
│   │
│   ├── models/
│   │   ├── user.dart
│   │   ├── restaurant.dart
│   │   ├── menu_item.dart
│   │   ├── cart_item.dart
│   │   └── order.dart
│   │
│   ├── services/
│   │   ├── api_service.dart
│   │   ├── auth_service.dart
│   │   └── storage_service.dart
│   │
│   └── constants/
│       ├── app_constants.dart
│       └── api_constants.dart
│
│
├── ├── merchant/                     # MALAEKA
│   │   │
│   │   ├── splash/
│   │   │   └── merchant_welcome_screen.dart
│   │   │
│   │   ├── auth/
│   │   │   ├── merchant_login_screen.dart
│   │   │   └── merchant_signup_screen.dart
│   │   │
│   │   ├── onboarding/
│   │   │   ├── business_setup_screen.dart
│   │   │   └── business_details_screen.dart
│   │   │
│   │   ├── dashboard/
│   │   │   └── merchant_dashboard_screen.dart
│   │   │
│   │   ├── orders/
│   │   │   ├── merchant_orders_screen.dart
│   │   │   ├── merchant_order_details_screen.dart
│   │   │   └── order_queue_screen.dart
│   │   │
│   │   ├── menu/
│   │   │   ├── menu_management_screen.dart
│   │   │   ├── add_product_screen.dart
│   │   │   ├── edit_product_screen.dart
│   │   │   └── category_management_screen.dart
│   │   │
│   │   ├── pickup/
│   │   │   ├── pickup_management_screen.dart
│   │   │   └── pickup_settings_screen.dart
│   │   │
│   │   ├── analytics/
│   │   │   └── merchant_analytics_screen.dart
│   │   │
│   │   ├── profile/
│   │   │   ├── merchant_profile_screen.dart
│   │   │   ├── business_settings_screen.dart
│   │   │   └── merchant_settings_screen.dart
│   │   │
│   │   └── widgets/
│   │       ├── order_card.dart
│   │       ├── dashboard_stat_card.dart
│   │       ├── merchant_product_card.dart
│   │       └── merchant_bottom_nav.dart
│
│
└── routes/
└── app_routes.dart
```