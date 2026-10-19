import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piko/app.dart';
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
}
