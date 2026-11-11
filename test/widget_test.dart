
import 'package:flutter_test/flutter_test.dart';
import 'package:kosfinder_app/main.dart';

void main() {
  testWidgets('KosFinder app test', (WidgetTester tester) async {
    await tester.pumpWidget(const KosFinderApp());

    expect(find.text('Login KosFinder'), findsOneWidget);
  });
}
