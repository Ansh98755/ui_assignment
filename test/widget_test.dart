import 'package:flutter_test/flutter_test.dart';
import 'package:ui_assignment/home_screen.dart';

void main() {
  testWidgets('Home screen loads', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Welcome, Mypcot !!'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
  });
}
