import 'package:flutter_test/flutter_test.dart';
import 'package:packmind_ai/main.dart';

void main() {
  testWidgets('PackMind opens animated splash screen with branding',
      (WidgetTester tester) async {
    await tester.pumpWidget(const PackMindApp());
    expect(find.text('PackMind AI'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });

  testWidgets('Tapping Get Started opens Home Dashboard',
      (WidgetTester tester) async {
    await tester.pumpWidget(const PackMindApp());
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();
    expect(find.text('Ask our AI Packaging Expert...'), findsOneWidget);
    expect(find.text('Popular Products'), findsOneWidget);
  });
}
