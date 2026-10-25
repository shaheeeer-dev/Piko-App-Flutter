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

## Figma screen reference

The SVG filenames are export names, **not screen sequence numbers**. Match by the
C-number and title visible inside each design. Keep the original export filenames
so existing references remain valid. Paths below follow the folder structure above;
planned screens may not have an implementation yet.

| Design | Screen | Local SVG | Implementation / planned location |
| --- | --- | --- | --- |
| C01 | Brand | `figma/Article.svg` | `lib/customer/splash/onboarding_page_view.dart` |
| C02 | Onboarding 1 | `figma/Article-1.svg` | `lib/customer/splash/onboarding_s1.dart` |
| C03 | Onboarding 2 · Pick up | `figma/Article-21.svg` | `lib/customer/splash/onboarding_s2.dart` |
| C04 | Log in | `figma/Article-2.svg` | `lib/customer/auth/login_screen.dart` |
| C05 | Sign up | `figma/Article-3.svg` | `lib/customer/auth/signup_screen.dart` |
| C06 | Home | `figma/Article-4.svg` | `lib/customer/home/home_screen.dart` |
| C07 | Search & discovery | `figma/Article-5.svg` | `lib/customer/home/search_screen.dart` |
| C08 | Café detail | `figma/Article-6.svg` | `lib/customer/restaurant/restaurant_detail_screen.dart` |
| C09 | Menu | `figma/Article-7.svg` | `lib/customer/restaurant/menu_screen.dart` |
| C10 | Customize item | `figma/Article-8.svg` | `lib/customer/restaurant/item_detail_screen.dart` |
| C11 | Cart | `figma/Article-9.svg` | `lib/customer/cart/cart_screen.dart` |
| C12 | Pickup time | `figma/Article-10.svg` | `lib/customer/checkout/pickup_time_screen.dart` (planned) |
| C13 | Checkout & payment | `figma/Article-11.svg` | `lib/customer/checkout/checkout_screen.dart` (planned) |
| C14 | Order confirmed | `figma/Article-12.svg` | `lib/customer/checkout/order_success_screen.dart` (planned) |
| C15 | Live order status | `figma/Article-13.svg` | `lib/customer/orders/active_order_screen.dart` (planned) |
| C16 | Ready for pickup | `figma/Article-14.svg` | `lib/customer/orders/pickup_code_screen.dart` (planned) |
| C17 | Orders & history | `figma/Article-15.svg` | `lib/customer/orders/orders_screen.dart` (planned) |
| C18 | Favorites | `figma/Article-16.svg` | Not yet assigned in the folder plan |
| C19 | Notifications | `figma/Article-17.svg` | `lib/customer/profile/notifications_screen.dart` (planned) |
| C20 | Profile | `figma/Article-18.svg` | `lib/customer/profile/profile_screen.dart` (planned) |
| C21 | Edit profile | `figma/Article-19.svg` | `lib/customer/profile/edit_profile_screen.dart` (planned) |
| C22 | Settings | `figma/Article-20.svg` | `lib/customer/profile/settings_screen.dart` (planned) |
