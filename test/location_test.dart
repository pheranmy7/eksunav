import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:eksunav/screens/location_screen.dart';

void main() {
  group('LocationScreen Widget Tests', () {
    testWidgets('renders LocationScreen and all UI elements correctly',
        (WidgetTester tester) async {
      // Build the LocationScreen widget
      await tester.pumpWidget(
        const MaterialApp(
          home: LocationScreen(),
        ),
      );

      // Verify that the MapWidget is rendered
      expect(find.byKey(const ValueKey("mapWidget")), findsOneWidget);

      // Verify that the overlay contains "My Location" and "Destination" text
      expect(find.text("My Location"), findsOneWidget);
      expect(find.text("Destination"), findsOneWidget);

      // Verify that the bottom navigation bar is rendered
      expect(find.byType(BottomNavigationBar), findsOneWidget);

      // Verify that the BottomNavigationBar has 3 items
      final bottomNavigationBar =
          tester.widget<BottomNavigationBar>(find.byType(BottomNavigationBar));
      expect(bottomNavigationBar.items.length, 3);

      // Verify navigation icons
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.location_on), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
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

      // Verify initial route is LocationScreen
      expect(find.byKey(const ValueKey("mapWidget")), findsOneWidget);

      // Tap on the Home icon in BottomNavigationBar
      await tester.tap(find.byIcon(Icons.home));
      await tester.pumpAndSettle();
      expect(find.text('Home Screen'), findsOneWidget);

      // Navigate back to LocationScreen
      await tester.tap(find.byIcon(Icons.location_on));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey("mapWidget")), findsOneWidget);

      // Tap on the Profile icon in BottomNavigationBar
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();
      expect(find.text('Profile Screen'), findsOneWidget);
    });
  });
}
