import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piko/app.dart';
import 'package:piko/shared/widgets/piko_button.dart';
import 'package:piko/shared/theme/app_theme.dart';
import 'package:piko/customer/cart/cart_screen.dart';
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
          expect(
            find.textContaining('Proceeding to pickup time'),
            findsOneWidget,
          );
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
}
