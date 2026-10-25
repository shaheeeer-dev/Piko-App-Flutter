import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piko/customer/auth/login_screen.dart';
import 'package:piko/customer/home/home_screen.dart';
import 'package:piko/customer/home/widgets/restaurant_card.dart';
import 'package:piko/customer/restaurant/restaurant_detail_screen.dart';
import 'package:piko/shared/services/favorite_cafes.dart';
import 'package:piko/shared/theme/app_theme.dart';
import 'package:piko/shared/widgets/piko_button.dart';

void main() {
  setUpAll(() async {
    await (FontLoader('Inter')
          ..addFont(rootBundle.load('assets/fonts/Inter-Regular.ttf'))
          ..addFont(rootBundle.load('assets/fonts/Inter-Bold.ttf')))
        .load();
  });
  setUp(() => FavoriteCafes.names.value = {});

  testWidgets('Home has no back arrow and groups cafés beneath the offer', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.lightTheme, home: const HomeScreen()),
    );
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsNothing);
    final home = find.text('Home').first;
    final location = find.text('PICKING UP NEAR');
    expect(
      tester.getTopLeft(location).dy - tester.getBottomLeft(home).dy,
      lessThan(35),
    );
    expect(
      tester.getTopLeft(find.text('Favorites')).dy,
      greaterThan(
        tester.getBottomLeft(find.text('Order ahead with Piko ↗')).dy,
      ),
    );
    expect(
      tester.getTopLeft(find.text('Explore more')).dy,
      greaterThan(tester.getBottomLeft(find.text('Favorites')).dy),
    );
    expect(find.textContaining('Tap the bookmark'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Saved café appears in Favorites and bookmark can be removed', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const RestaurantDetailScreen(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.bookmark_outline_rounded));
    await tester.pumpAndSettle();
    expect(FavoriteCafes.contains('June Coffee'), isTrue);
    await tester.pumpWidget(
      MaterialApp(
        key: UniqueKey(),
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
      ),
    );
    await tester.pumpAndSettle();
    final cards = tester
        .widgetList<RestaurantCard>(find.byType(RestaurantCard))
        .toList();
    expect(cards.map((card) => card.title), ['June Coffee', 'Mocca']);
    await tester.pumpWidget(
      MaterialApp(
        key: UniqueKey(),
        theme: AppTheme.lightTheme,
        home: const RestaurantDetailScreen(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.bookmark_rounded), findsOneWidget);
    await tester.tap(find.byIcon(Icons.bookmark_rounded));
    await tester.pumpAndSettle();
    expect(FavoriteCafes.names.value, isEmpty);
  });

  testWidgets('Logging in removes earlier authentication routes', (
    tester,
  ) async {
    final navigator = GlobalKey<NavigatorState>();
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navigator,
        theme: AppTheme.lightTheme,
        home: const Scaffold(body: Text('Older login page')),
      ),
    );
    navigator.currentState!.push(
      MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
    );
    await tester.pumpAndSettle();
    final login = find.byType(PrimaryButton);
    await tester.ensureVisible(login);
    await tester.tap(login);
    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(navigator.currentState!.canPop(), isFalse);
    expect(find.text('Older login page'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
