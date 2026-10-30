import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piko/app.dart';
import 'package:piko/shared/widgets/piko_button.dart';
import 'package:piko/shared/theme/app_theme.dart';
import 'package:piko/customer/cart/cart_screen.dart';
import 'package:piko/customer/checkout/checkout_screen.dart';
import 'package:piko/customer/checkout/order_success_screen.dart';
import 'package:piko/customer/checkout/pickup_time_screen.dart';
import 'package:piko/customer/restaurant/item_detail_screen.dart';
import 'package:piko/customer/restaurant/menu_screen.dart';
import 'package:piko/customer/restaurant/restaurant_detail_screen.dart';

void main() {
  setUpAll(() async {
    final fonts = FontLoader('Inter')
      ..addFont(rootBundle.load('assets/fonts/Inter-Regular.ttf'))
      ..addFont(rootBundle.load('assets/fonts/Inter-Bold.ttf'));
    await fonts.load();
  });
  for (final size in [const Size(390, 844), const Size(320, 568)]) {
    for (final cart in [false, true]) {
      testWidgets('${cart ? 'Cart' : 'Café'} keeps a compact footer at $size', (
        tester,
      ) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.lightTheme,
            home: cart ? const CartScreen() : const RestaurantDetailScreen(),
          ),
        );
        await tester.pumpAndSettle();

        final button = find.byType(PrimaryButton);
        final footer = tester.getRect(button);
        expect(footer.height, inInclusiveRange(48, 80));
        expect(footer.top, greaterThan(size.height * 0.7));
        final heading = tester.getRect(
          find.text(cart ? 'Your little pick-me-up' : 'June Coffee'),
        );
        expect(heading.top, greaterThanOrEqualTo(0));
        expect(heading.bottom, lessThan(footer.top));
        expect(tester.takeException(), isNull);

        // Check navigation at the standard size; narrow menu layout is separate.
        if (size.width < 390) return;
        await tester.tap(button);
        await tester.pumpAndSettle();
        if (cart) {
          expect(find.byType(PickupTimeScreen), findsOneWidget);
        } else {
          expect(find.byType(MenuScreen), findsOneWidget);
        }
        expect(tester.takeException(), isNull);
      });
    }
  }

  testWidgets('Piko brand screen loads', (WidgetTester tester) async {
    await tester.pumpWidget(const PikoApp());

    expect(find.text('piko'), findsOneWidget);
  });

  testWidgets('Restaurant detail screen loads with café info and CTA', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: RestaurantDetailScreen(restaurantName: 'June Coffee'),
      ),
    );

    expect(find.text('June Coffee'), findsOneWidget);
    expect(find.text('Explore the menu'), findsOneWidget);
    expect(find.text('Ready in 10–15 minutes'), findsOneWidget);
  });

  testWidgets('Item detail screen loads with sizes and add CTA', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ItemDetailScreen(title: 'Honey oat latte', basePrice: 650),
      ),
    );

    expect(find.text('Honey oat latte'), findsOneWidget);
    expect(find.text('Choose a size'), findsOneWidget);
    expect(find.text('Make it yours'), findsOneWidget);
    expect(find.text('Add'), findsOneWidget);
    expect(find.text('Rs. 650'), findsWidgets);
  });

  testWidgets('Menu screen loads with categories, items, and cart bar', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: MenuScreen(restaurantName: 'June Coffee')),
    );

    expect(find.text('June Coffee'), findsOneWidget);
    expect(find.text('Freshly made. Yours to pick up.'), findsOneWidget);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.text('Coffee'), findsOneWidget);
    expect(find.text('Honey oat latte'), findsOneWidget);
    expect(find.text('View cart · 2 items'), findsOneWidget);
  });

  testWidgets('Cart screen loads with items, summary, and pickup time CTA', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CartScreen(restaurantName: 'June Coffee', location: 'Gulberg'),
      ),
    );

    expect(find.text('Your little pick-me-up'), findsOneWidget);
    expect(find.text('June Coffee • Gulberg'), findsOneWidget);
    expect(find.text('Honey oat latte'), findsOneWidget);
    expect(find.text('Butter croissant'), findsOneWidget);
    expect(find.text('Pickup only'), findsOneWidget);
    expect(find.text('Choose pickup time'), findsOneWidget);
    expect(find.text('Total'), findsOneWidget);
  });

  testWidgets('Pickup time screen loads with ASAP option, time slots, and CTA', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: PickupTimeScreen(
          restaurantName: 'June Coffee',
          openHours: 'Open until 8 PM',
        ),
      ),
    );

    expect(find.text('When works\nfor you?'), findsOneWidget);
    expect(find.text('June Coffee • Open until 8 PM'), findsOneWidget);
    expect(find.text('As soon as possible'), findsOneWidget);
    expect(find.text('Or choose a time'), findsOneWidget);
    expect(find.textContaining('Today, '), findsOneWidget);
    expect(find.text('Tomorrow'), findsOneWidget);
    expect(find.text('12:30 PM'), findsOneWidget);
    expect(find.text('12:45 PM'), findsOneWidget);
    expect(find.textContaining('Confirm •'), findsOneWidget);
  });

  testWidgets(
    'Confirming pickup time shows order confirmation sheet and navigates home',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PickupTimeScreen(
            restaurantName: 'June Coffee',
            openHours: 'Open until 8 PM',
            showConfirmationSheet: true,
          ),
        ),
      );

      final confirmButton = find.textContaining('Confirm •');
      expect(confirmButton, findsOneWidget);
      await tester.tap(confirmButton);
      await tester.pumpAndSettle();

      expect(find.text('Order confirmed!'), findsOneWidget);
      expect(find.text('Preparing'), findsOneWidget);
      expect(find.text('Back to home'), findsOneWidget);

      await tester.tap(find.text('Back to home'));
      await tester.pumpAndSettle();
      expect(find.byType(PickupTimeScreen), findsNothing);
    },
  );

  testWidgets(
    'Confirming pickup time navigates to Checkout & payment screen',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PickupTimeScreen(
            restaurantName: 'June Coffee',
            openHours: 'Open until 8 PM',
          ),
        ),
      );

      final confirmButton = find.textContaining('Confirm •');
      expect(confirmButton, findsOneWidget);
      await tester.tap(confirmButton);
      await tester.pumpAndSettle();

      expect(find.byType(CheckoutScreen), findsOneWidget);
      expect(find.text('One last thing.'), findsOneWidget);
      expect(
        find.text("Check your details, then you're all set."),
        findsOneWidget,
      );
      expect(find.text('Checkout & payment'), findsOneWidget);
    },
  );

  testWidgets(
    'Checkout screen displays details, allows editing contact, and paying navigates to Order confirmed',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CheckoutScreen(
            restaurantName: 'June Coffee',
            restaurantLocation: 'Gulberg',
            pickupTimeLabel: 'Today • 12:30 PM',
            subtotal: 1070,
            serviceFee: 50,
            totalPrice: 1120,
          ),
        ),
      );

      expect(find.text('One last thing.'), findsOneWidget);
      expect(find.text('Today • 12:30 PM'), findsOneWidget);
      expect(find.text('June Coffee, Gulberg'), findsOneWidget);
      expect(find.text('Ayesha Khan'), findsOneWidget);
      expect(find.text('+92 300 123 4567'), findsOneWidget);
      expect(find.text('Edit'), findsOneWidget);
      expect(find.text('Payment method'), findsOneWidget);
      expect(find.text('Visa ending in 4242'), findsOneWidget);
      expect(find.text('Pay at pickup'), findsOneWidget);
      expect(find.text('Add a card'), findsOneWidget);
      expect(find.text('Subtotal'), findsOneWidget);
      expect(find.text('Service fee'), findsOneWidget);
      expect(find.text('Pay Rs. 1,120'), findsOneWidget);

      // Tap Pay and settle future delay
      await tester.tap(find.text('Pay Rs. 1,120'));
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Processing...'), findsOneWidget);
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      // Navigated to OrderSuccessScreen (C14)
      expect(find.byType(OrderSuccessScreen), findsOneWidget);
      expect(find.text("You're on the list."), findsOneWidget);
      expect(find.text('Track my order'), findsOneWidget);
    },
  );

  testWidgets(
    'Adding customized item in menu screen updates live cart bar and transfers to cart',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MenuScreen(restaurantName: 'June Coffee'),
        ),
      );

      expect(find.text('View cart · 2 items'), findsOneWidget);
      expect(find.text('Rs. 1070'), findsOneWidget);

      await tester.tap(find.text('Honey oat latte'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Large + Rs. 150'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();

      expect(find.text('View cart · 3 items'), findsOneWidget);
      expect(find.text('Rs. 1870'), findsOneWidget);

      await tester.tap(find.text('View cart · 3 items'));
      await tester.pumpAndSettle();

      expect(find.byType(CartScreen), findsOneWidget);
      expect(find.text('Rs. 1,870'), findsOneWidget);
    },
  );
}
