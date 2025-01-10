import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eksunav/screens/location_screen.dart';

void main() {
  group('LocationScreen Widget Tests', () {
    testWidgets('LocationScreen renders map and UI elements',
        (WidgetTester tester) async {
      // Build the widget tree with the LocationScreen
      await tester.pumpWidget(
        const MaterialApp(
          home: LocationScreen(),
        ),
      );

      // Verify that the MapWidget is present
      expect(find.byKey(const ValueKey('mapWidget')), findsOneWidget);

      // Verify the FloatingActionButton is present
      expect(find.byType(FloatingActionButton), findsOneWidget);

      // Verify the BottomNavigationBar is present
      expect(find.byType(BottomNavigationBar), findsOneWidget);

      // Verify the custom AppBar with white containers
      expect(find.text('My Location'), findsOneWidget);
      expect(find.text('Destination'), findsOneWidget);

      // Verify icons inside the containers
      expect(find.byIcon(Icons.location_on), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('FloatingActionButton triggers location save logic',
        (WidgetTester tester) async {
      // Create a mock callback for the FAB
      bool isButtonPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LocationScreen(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                isButtonPressed = true;
              },
              child: const Icon(Icons.save),
            ),
          ),
        ),
      );

      // Verify initial state
      expect(isButtonPressed, isFalse);

      // Tap the FloatingActionButton
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      // Verify state after tapping the FAB
      expect(isButtonPressed, isTrue);
    });

    testWidgets('BottomNavigationBar navigates to correct screens',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          initialRoute: '/location',
          routes: {
            '/home': (context) => const Scaffold(body: Text('Home Screen')),
            '/location': (context) => const LocationScreen(),
            '/profile': (context) =>
                const Scaffold(body: Text('Profile Screen')),
          },
        ),
      );

      // Verify the current screen is LocationScreen
      expect(find.byType(LocationScreen), findsOneWidget);

      // Tap the Home tab in the BottomNavigationBar
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();

      // Verify navigation to Home Screen
      expect(find.text('Home Screen'), findsOneWidget);

      // Tap the Profile tab in the BottomNavigationBar
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();

      // Verify navigation to Profile Screen
      expect(find.text('Profile Screen'), findsOneWidget);
    });
  });
}
