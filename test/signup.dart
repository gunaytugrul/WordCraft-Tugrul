import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:languagelearningapp/screens/home_screen.dart';
import 'package:languagelearningapp/screens/signup_screen.dart';

void main() {
  testWidgets('Sign Up Screen Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SignUpScreen(),
    ));

    // Check if the Sign Up screen loads properly
    expect(find.text('Sign Up'), findsOneWidget);

    // Fill in the text fields
    await tester.enterText(find.byKey(const Key('userName')), 'esrada');
    await tester.enterText(find.byKey(const Key('email')), 'esrada@gmail.com');
    await tester.enterText(find.byKey(const Key('password')), 'New123');

    // Tap the Sign Up button
    await tester.tap(find.text('Sign Up'));
    await tester.pump();

    // Wait for the navigation to the Home Screen
    await tester.pump(const Duration(seconds: 1));

    // Check if the navigation occurred properly
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
