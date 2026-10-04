import 'package:flutter_test/flutter_test.dart';
import 'package:piko/app.dart';

void main() {
  testWidgets('Piko brand screen loads', (WidgetTester tester) async {
    await tester.pumpWidget(const PikoApp());

    expect(find.text('piko'), findsOneWidget);
  });
}
