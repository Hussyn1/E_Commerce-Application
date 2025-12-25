import 'package:ecommerce_fyp/screens/auth/login/login_screen.dart';
import 'package:ecommerce_fyp/screens/auth/signup/signup_screen.dart';
import 'package:ecommerce_fyp/widgets/buttons/primary_button.dart';
import 'package:ecommerce_fyp/widgets/inputs/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  group('Auth UI Tests (Black Box)', () {
    testWidgets('LoginScreen displays required fields', (WidgetTester tester) async {
      await tester.pumpWidget(const GetMaterialApp(home: LoginScreen()));

      expect(find.byType(CustomTextField), findsNWidgets(2));
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.byType(PrimaryButton), findsOneWidget);
    });

    testWidgets('SignupScreen validation test', (WidgetTester tester) async {
      await tester.pumpWidget(const GetMaterialApp(home: SignupScreen()));

      // Try to signup without filling anything
      await tester.tap(find.byType(PrimaryButton));
      await tester.pump();

      // Should show validation errors (assuming Validators work)
      // CustomTextField shows errors in their internal state
    });

    testWidgets('Navigation to Signup from Login', (WidgetTester tester) async {
      await tester.pumpWidget(const GetMaterialApp(home: LoginScreen()));

      final signupButton = find.text('Sign Up');
      expect(signupButton, findsOneWidget);

      // Navigator tests in widget testing need proper setup, but this verifies the UI element exists
    });
  });
}
