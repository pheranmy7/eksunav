import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:eksunav/screens/home_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('HomeScreen Widget Tests', () {
    testWidgets(
        'should display the AppBar with no height and transparent background',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      // Ensure AppBar exists
      expect(find.byType(AppBar), findsOneWidget);

      // AppBar height and background tests
      final AppBar appBar = tester.widget(find.byType(AppBar));
      expect(appBar.toolbarHeight, 0);
      expect(appBar.backgroundColor, Colors.transparent);
    });

    testWidgets('should display search bar in the top bar',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      // Ensure TextField for Search exists
      expect(find.byType(TextField), findsOneWidget);

      // Check placeholder text
      final TextField searchField = tester.widget(find.byType(TextField));
      expect(searchField.decoration?.hintText, "Search");
    });

    testWidgets('should display Recent Search section',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      // Verify "Recent Search" header exists
      expect(find.text("Recent Search"), findsOneWidget);

      // Verify recent search description exists
      expect(
        find.text("Recently you searched about best restaurants near you."),
        findsOneWidget,
      );
    });

    testWidgets(
        'should display Weather section with temperature, date, and location',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      // Check temperature, date, and location
      expect(find.text("25°C"), findsOneWidget);
      expect(find.text("7th January 2025"), findsOneWidget);
      expect(find.text("Ekiti State University, Ado-Ekiti"), findsOneWidget);

      // Check weather icon exists
      expect(find.byIcon(Icons.cloud), findsOneWidget);
    });

    testWidgets('should display Category grid with correct titles',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      // Check category titles
      expect(find.text("Restaurants"), findsOneWidget);
      expect(find.text("Banks"), findsOneWidget);
      expect(find.text("Libraries"), findsOneWidget);
      expect(find.text("Cybercafes"), findsOneWidget);
    });

    testWidgets('should display Recents section with correct items',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      // Check Recents header
      expect(find.text("Recents"), findsOneWidget);

      // Check recent items
      expect(find.text("Rite Meal Restaurant"), findsOneWidget);
      expect(find.text("Gtbank"), findsOneWidget);
      expect(find.text("Main Campus Library"), findsOneWidget);
      expect(find.text("Horla Cafe"), findsOneWidget);
    });

    testWidgets('should navigate using BottomNavigationBar',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        routes: {
          '/home': (context) => const HomeScreen(),
          '/location': (context) =>
              const Scaffold(body: Center(child: Text('Location Screen'))),
          '/profile': (context) =>
              const Scaffold(body: Center(child: Text('Profile Screen'))),
        },
        initialRoute: '/home',
      ));

      // Check initial Home tab is active
      expect(find.text('Home'), findsOneWidget);

      // Tap on Location tab
      await tester.tap(find.text('Location'));
      await tester.pumpAndSettle();
      expect(find.text('Location Screen'), findsOneWidget);

      // Tap on Profile tab
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();
      expect(find.text('Profile Screen'), findsOneWidget);
    });

    testWidgets('should display Account Options dialog on user icon tap',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      // Tap on user icon
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      // Check Account Options dialog is displayed
      expect(find.text("Account Options"), findsOneWidget);
      expect(find.text("Sign In"), findsOneWidget);
      expect(find.text("Log Out"), findsOneWidget);
    });

    testWidgets('should sign out the user on Log Out button tap',
        (WidgetTester tester) async {
      // Simulate user sign-in by using a non-null currentUser
      final FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signInAnonymously();

      await tester.pumpWidget(MaterialApp(
        home: const HomeScreen(),
      ));

      // Tap on user icon
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      // Tap Log Out
      await tester.tap(find.text("Log Out"));
      await tester.pumpAndSettle();

      // Check if Snackbar is displayed
      expect(find.text("You have been logged out."), findsOneWidget);
    });
  });
}
