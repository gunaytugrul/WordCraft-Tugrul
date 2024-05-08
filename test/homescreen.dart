import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:languagelearningapp/screens/home_screen.dart';
import 'package:languagelearningapp/screens/levels/advanced_level_screen.dart';
import 'package:languagelearningapp/screens/levels/beginner_level_screen.dart';
import 'package:languagelearningapp/screens/levels/intermediate_level_screen.dart';


void main() {
  testWidgets('Home Screen Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Check if the title 'Ana Sayfa' appears on the AppBar
    expect(find.text('Ana Sayfa'), findsOneWidget);

    // Tap the Beginner Level button and verify the navigation
    await tester.tap(find.text('Beginner Level'));
    await tester.pumpAndSettle();
    expect(find.byType(BeginnerLevelPage), findsOneWidget);

    // Tap the Intermediate Level button and verify the navigation
    await tester.tap(find.text('Intermediate Level'));
    await tester.pumpAndSettle();
    expect(find.byType(IntermediateLevelPage), findsOneWidget);

    // Tap the Advanced Level button and verify the navigation
    await tester.tap(find.text('Advanced Level'));
    await tester.pumpAndSettle();
    expect(find.byType(AdvancedLevelPage), findsOneWidget);

    // Add more test cases as needed for any specific functionalities or scenarios
  });
}
