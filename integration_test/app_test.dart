import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reptask/pages/home_page.dart';
import 'package:reptask/pages/login_page.dart';

void main() {
  testWidgets('Invalid Password Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    // Enter the email.
    await tester.enterText(find.byKey(const ValueKey('email_field')), 'salles');

    // Enter an invalid password.
    await tester.enterText(
        find.byKey(const ValueKey('password_field')), 'invalid');

    // Tap the login button.
    await tester.tap(find.byKey(const ValueKey('login_button')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await Future.delayed(const Duration(seconds: 1));

    // Verify that the "Dados Incorretos" dialog is opened.
    expect(find.text('Dados Incorretos'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);

    // Tap the OK button on the dialog.
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await Future.delayed(const Duration(seconds: 1));

    // Verify that the dialog is dismissed.
    expect(find.text('Dados Incorretos'), findsNothing);
    await Future.delayed(const Duration(seconds: 1));
  });

  testWidgets('Valid Login Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    // Enter the email.
    await tester.enterText(
        find.byKey(const ValueKey('email_field')), 'salles@gmail.com');

    // Enter a valid password.
    await tester.enterText(
        find.byKey(const ValueKey('password_field')), '12345678');

    // Tap the login button.
    await tester.tap(find.byKey(const ValueKey('login_button')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await Future.delayed(const Duration(seconds: 1));

    // Verify that the new widget is pushed to the navigator.
    expect(find.byType(MyHomePage), findsOneWidget);
    await Future.delayed(const Duration(seconds: 1));
  });
}
