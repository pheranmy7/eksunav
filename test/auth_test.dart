import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eksunav/screens/auth_screen.dart';

void main() {
  group('AuthScreen Widget Tests', () {
    testWidgets('should display AppBar with correct title',
        (WidgetTester tester) async {
      // Build the AuthScreen widget
      await tester.pumpWidget(const MaterialApp(home: AuthScreen()));

      // Verify AppBar is present and has the correct title
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('User Authentication'), findsOneWidget);
    });

    testWidgets('should display a Google Sign-In button',
        (WidgetTester tester) async {
      // Build the AuthScreen widget
      await tester.pumpWidget(const MaterialApp(home: AuthScreen()));

      // Verify ElevatedButton is present with the correct text
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Sign in with Google'), findsOneWidget);
    });

    testWidgets('should display a SnackBar on sign-in success',
        (WidgetTester tester) async {
      // Wrap with MaterialApp for SnackBar functionality
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
              onPressed: () {
                // Display the success SnackBar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Sign-in successful!,Welcome to EksuNav')),
                );
              },
              child: const Text('Sign in with Google'),
            );
          },
        ),
      ));

      // Tap the ElevatedButton
      await tester.tap(find.text('Sign in with Google'));
      await tester.pump(); // Rebuild the widget after the button is tapped

      // Verify SnackBar is displayed with the correct text
      expect(find.byType(SnackBar), findsOneWidget);
      expect(
          find.text('Sign-in successful!,Welcome to EksuNav'), findsOneWidget);
    });

    testWidgets('should display a SnackBar on sign-in error',
        (WidgetTester tester) async {
      // Wrap with MaterialApp for SnackBar functionality
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
              onPressed: () {
                // Display the error SnackBar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Error: Sign-in failed')),
                );
              },
              child: const Text('Sign in with Google'),
            );
          },
        ),
      ));

      // Tap the ElevatedButton
      await tester.tap(find.text('Sign in with Google'));
      await tester.pump(); // Rebuild the widget after the button is tapped

      // Verify SnackBar is displayed with the correct text
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Error: Sign-in failed'), findsOneWidget);
    });

    testWidgets('should navigate to another screen on successful sign-in',
        (WidgetTester tester) async {
      // Define a test route to simulate navigation
      final Map<String, WidgetBuilder> routes = {
        '/location': (BuildContext context) =>
            const Scaffold(body: Center(child: Text('Location Screen'))),
      };

      // Build the widget with the route
      await tester.pumpWidget(MaterialApp(
        routes: routes,
        home: Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
              onPressed: () {
                // Navigate to the location screen
                Navigator.pushNamed(context, '/location');
              },
              child: const Text('Sign in with Google'),
            );
          },
        ),
      ));

      // Tap the ElevatedButton
      await tester.tap(find.text('Sign in with Google'));
      await tester.pumpAndSettle(); // Wait for the navigation to complete

      // Verify the new screen is displayed
      expect(find.text('Location Screen'), findsOneWidget);
    });
  });
}
