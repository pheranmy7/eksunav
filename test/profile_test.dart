import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eksunav/screens/profile_screen.dart';

void main() {
  group('ProfileScreen Widget Tests', () {
    testWidgets('should display the user name, avatar, and ID section',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileScreen(),
        ),
      );

      // Assert
      expect(find.text('Feranmi'), findsOneWidget);
      expect(find.byType(CircleAvatar), findsNWidgets(3));
      expect(find.text('id 17382903'), findsOneWidget);
    });

    testWidgets('should display the "Now is" section correctly',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileScreen(),
        ),
      );

      // Assert
      expect(find.text('Now is'), findsOneWidget);
      expect(find.text('Eksu Main Auditorium'), findsOneWidget);
      expect(find.text('Since 8:54'), findsOneWidget);
      expect(find.text('School'), findsOneWidget);
      expect(find.text('8 min updated'), findsOneWidget);
    });

    testWidgets('should display the "Last Updates" section collapsed initially',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileScreen(),
        ),
      );

      // Assert
      expect(find.text('Last Updates'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_drop_down), findsOneWidget);
      expect(find.byIcon(Icons.arrow_drop_up), findsNothing);
      expect(find.text('Location 1'), findsNothing); // Initially collapsed
    });

    testWidgets(
        'should expand and collapse the "Last Updates" section when the icon is tapped',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileScreen(),
        ),
      );

      // Expand the section
      await tester.tap(find.byIcon(Icons.arrow_drop_down));
      await tester.pumpAndSettle();

      // Assert expanded state
      expect(find.byIcon(Icons.arrow_drop_up), findsOneWidget);
      expect(find.byIcon(Icons.arrow_drop_down), findsNothing);
      expect(find.text('Location 1'), findsOneWidget);
      expect(find.text('Location 5'), findsOneWidget);

      // Collapse the section
      await tester.tap(find.byIcon(Icons.arrow_drop_up));
      await tester.pumpAndSettle();

      // Assert collapsed state
      expect(find.byIcon(Icons.arrow_drop_down), findsOneWidget);
      expect(find.byIcon(Icons.arrow_drop_up), findsNothing);
      expect(find.text('Location 1'), findsNothing);
    });

    testWidgets('should navigate to other screens via BottomNavigationBar',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          routes: {
            '/home': (context) => const Scaffold(body: Text('Home Screen')),
            '/location': (context) =>
                const Scaffold(body: Text('Location Screen')),
            '/profile': (context) => const ProfileScreen(),
          },
          home: const ProfileScreen(),
        ),
      );

      // Navigate to Home screen
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(find.text('Home Screen'), findsOneWidget);

      // Navigate to Location screen
      await tester.tap(find.text('Location'));
      await tester.pumpAndSettle();
      expect(find.text('Location Screen'), findsOneWidget);

      // Navigate back to Profile screen
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();
      expect(find.text('Feranmi'), findsOneWidget); // Back to Profile screen
    });
  });
}
