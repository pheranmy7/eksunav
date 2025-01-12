import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:eksunav/screens/home_screen.dart';

void main() {
  group('HomeScreen Widget Tests', () {
    testWidgets('Renders essential widgets', (WidgetTester tester) async {
      // Build the HomeScreen widget
      await tester.pumpWidget(const HomeScreen());

      // Verify the presence of key UI elements
      expect(find.byType(Drawer), findsOneWidget);
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Recent Search'), findsOneWidget);
      expect(find.text('Category'), findsOneWidget);
      expect(find.text('Recents'), findsOneWidget);
    });

    testWidgets('Drawer menu items render correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      // Open the drawer
      final drawerButton = find.byIcon(Icons.menu);
      expect(drawerButton, findsOneWidget);
      await tester.tap(drawerButton);
      await tester.pumpAndSettle();

      // Check for drawer menu items
      expect(find.text('Favorites'), findsOneWidget);
      expect(find.text('Recap/Analytics'), findsOneWidget);
      expect(find.text('Notification Settings'), findsOneWidget);
      expect(find.text('Help & Support'), findsOneWidget);
      expect(find.text('Feedback'), findsOneWidget);
      expect(find.text('About the App'), findsOneWidget);
      expect(find.text('Campus News & Updates'), findsOneWidget);
      expect(find.text('Emergency Contact'), findsOneWidget);
    });

    testWidgets('Theme toggle switch works correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      // Open the drawer
      final drawerButton = find.byIcon(Icons.menu);
      await tester.tap(drawerButton);
      await tester.pumpAndSettle();

      // Toggle theme switch
      final themeSwitch = find.byType(Switch);
      expect(themeSwitch, findsOneWidget);

      // Verify initial state and toggle
      expect((tester.widget(themeSwitch) as Switch).value, isFalse);
      await tester.tap(themeSwitch);
      await tester.pump();
      expect((tester.widget(themeSwitch) as Switch).value, isTrue);
    });

    testWidgets('BottomNavigationBar navigates correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const HomeScreen(),
        routes: {
          '/location': (context) =>
              const Scaffold(body: Text('Location Screen')),
          '/profile': (context) => const Scaffold(body: Text('Profile Screen')),
        },
      ));

      // Verify BottomNavigationBar exists
      final bottomNavBar = find.byType(BottomNavigationBar);
      expect(bottomNavBar, findsOneWidget);

      // Tap on 'Location' tab
      await tester.tap(find.text('Location'));
      await tester.pumpAndSettle();
      expect(find.text('Location Screen'), findsOneWidget);

      // Tap on 'Profile' tab
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();
      expect(find.text('Profile Screen'), findsOneWidget);
    });

    testWidgets('Category grid items render correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      // Check for grid items
      expect(find.text('Restaurants'), findsOneWidget);
      expect(find.text('Banks'), findsOneWidget);
      expect(find.text('Libraries'), findsOneWidget);
      expect(find.text('Cybercafes'), findsOneWidget);
    });

    testWidgets('Recents items render correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      // Check for recent items
      expect(find.text('Rite Meal Restaurant'), findsOneWidget);
      expect(find.text('Gtbank'), findsOneWidget);
      expect(find.text('Main Campus Library'), findsOneWidget);
      expect(find.text('Horla Cafe'), findsOneWidget);
    });

    testWidgets('Weather information renders correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      // Check for weather details
      expect(find.text('25°C'), findsOneWidget);
      expect(find.text('7th January 2025'), findsOneWidget);
      expect(find.text('Ekiti State University, Ado-Ekiti'), findsOneWidget);
    });

    testWidgets('Search functionality triggers correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      // Tap on the search bar and enter text
      final searchField = find.byType(TextField);
      expect(searchField, findsOneWidget);

      await tester.enterText(searchField, 'Library');
      expect(find.text('Library'), findsOneWidget);
    });

    testWidgets('Account options dialog renders correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      // Tap on the account icon
      final accountIcon = find.byIcon(Icons.person);
      await tester.tap(accountIcon);
      await tester.pumpAndSettle();

      // Verify the dialog and its options
      expect(find.text('Account Options'), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);
      expect(find.text('Log Out'), findsOneWidget);
    });
  });
}
