import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eksunav/screens/home_screen.dart';

void main() {
  testWidgets(
      'HomeScreen displays top bar with drawer, search bar, and user icon',
      (WidgetTester tester) async {
    // Build the HomeScreen.
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // Verify the top bar elements are present.
    expect(find.byIcon(Icons.menu), findsOneWidget); // Drawer icon
    expect(find.byType(TextField), findsOneWidget); // Search bar
    expect(find.byIcon(Icons.person), findsOneWidget); // User icon
  });

  testWidgets('HomeScreen displays recent search text and subtitle',
      (WidgetTester tester) async {
    // Build the HomeScreen.
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // Verify the "Recent Search" section.
    expect(find.text("Recent Search"), findsOneWidget);
    expect(find.text("Recently you searched about best restaurants near you."),
        findsOneWidget);
  });

  testWidgets('HomeScreen displays weather information box',
      (WidgetTester tester) async {
    // Build the HomeScreen.
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // Verify weather information is displayed correctly.
    expect(find.text("25°C"), findsOneWidget); // Temperature
    expect(find.text("7th January 2025"), findsOneWidget); // Date
    expect(find.text("Ekiti State University, Ado-Ekiti"),
        findsOneWidget); // Location
    expect(find.byIcon(Icons.cloud), findsOneWidget); // Cloud icon
    expect(find.byIcon(Icons.location_on), findsOneWidget); // Location icon
  });

  testWidgets('HomeScreen displays categories', (WidgetTester tester) async {
    // Build the HomeScreen.
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Verify the Category section is displayed.
    expect(find.text('Category'), findsOneWidget);

    // Verify the category cards are displayed.
    expect(find.text('Restaurants'), findsOneWidget);
    expect(find.text('9 locations'), findsOneWidget);
    expect(find.text('Banks'), findsOneWidget);
    expect(find.text('8 locations'), findsOneWidget);
    expect(find.text('Libraries'), findsOneWidget);
    expect(find.text('1 location'), findsOneWidget);
    expect(find.text('Cybercafes'), findsOneWidget);
    expect(find.text('40 locations'), findsOneWidget);
  });

  testWidgets('HomeScreen displays Recents section',
      (WidgetTester tester) async {
    // Build the HomeScreen.
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // Verify the Recents section title is displayed.
    expect(find.text('Recents'), findsOneWidget);

    // Verify the Recents items are displayed with correct details.
    expect(
        find.byIcon(Icons.location_on), findsNWidgets(4)); // 4 location icons
    expect(find.text('Restaurants'), findsOneWidget);
    expect(find.text('Rite Meal Restaurant'), findsOneWidget);
    expect(find.text('700m'), findsOneWidget);

    expect(find.text('Banks'), findsOneWidget);
    expect(find.text('Gtbank'), findsOneWidget);
    expect(find.text('400m'), findsOneWidget);

    expect(find.text('Libraries'), findsOneWidget);
    expect(find.text('Main Campus Library'), findsOneWidget);
    expect(find.text('900m'), findsOneWidget);

    expect(find.text('Cybercafes'), findsOneWidget);
    expect(find.text('Horla Cafe'), findsOneWidget);
    expect(find.text('60m'), findsOneWidget);
  });

  testWidgets('HomeScreen displays bottom navigation bar with correct tabs',
      (WidgetTester tester) async {
    // Build the HomeScreen.
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // Verify bottom navigation bar items are present.
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Location'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.location_on), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);
  });

  testWidgets('HomeScreen content is scrollable when space is limited',
      (WidgetTester tester) async {
    // Build the HomeScreen.
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );

    // Verify the content is scrollable.
    final finder = find.text('Recents');
    expect(finder, findsOneWidget);

    // Ensure scrolling works.
    await tester.drag(
        find.byType(SingleChildScrollView), const Offset(0, -300));
    await tester.pump();

    // Verify the Recents section is still visible after scrolling.
    expect(finder, findsOneWidget);
  });
}
