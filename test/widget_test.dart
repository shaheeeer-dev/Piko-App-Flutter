import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piko/app.dart';
import 'package:piko/customer/restaurant/item_detail_screen.dart';
import 'package:piko/customer/restaurant/menu_screen.dart';
import 'package:piko/customer/restaurant/restaurant_detail_screen.dart';

void main() {
  testWidgets('Piko brand screen loads', (WidgetTester tester) async {
    await tester.pumpWidget(const PikoApp());

    expect(find.text('piko'), findsOneWidget);
  });

  testWidgets('Restaurant detail screen loads with café info and CTA', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: RestaurantDetailScreen(
          restaurantName: 'June Coffee',
        ),
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
        home: ItemDetailScreen(
          title: 'Honey oat latte',
          basePrice: 650,
        ),
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
      const MaterialApp(
        home: MenuScreen(
          restaurantName: 'June Coffee',
        ),
      ),
    );

    expect(find.text('June Coffee'), findsOneWidget);
    expect(find.text('Freshly made. Yours to pick up.'), findsOneWidget);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.text('Coffee'), findsOneWidget);
    expect(find.text('Honey oat latte'), findsOneWidget);
    expect(find.text('View cart · 2 items'), findsOneWidget);
  });
}
