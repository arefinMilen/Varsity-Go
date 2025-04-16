import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:varsitygo_app/main.dart';
import 'package:varsitygo_app/screens/bus_detail_screen.dart';

void main() {
  group('VarsityGo App Tests', () {
    // Test the home screen widgets and functionality
    group('Home Screen Tests', () {
      testWidgets('AppBar displays correct title', (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(home: VarsityGoApp()));
        expect(find.text('VarsityGo'), findsOneWidget);
      });

      testWidgets('Displays list of buses', (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(home: VarsityGoApp()));

        expect(find.byType(ListView), findsOneWidget);
        expect(find.text('Campus Express'), findsOneWidget);
        expect(find.text('North Line'), findsOneWidget);
      });

      testWidgets('Bus items are tappable and navigate to details', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: VarsityGoApp(),
            routes: {'/bus': (context) => BusDetailScreen()},
          ),
        );

        await tester.tap(find.text('Campus Express').first);
        await tester.pumpAndSettle();

        expect(find.byType(BusDetailScreen), findsOneWidget);
      });
    });

    // Test the bus detail screen functionality
    group('Bus Detail Screen Tests', () {
      testWidgets('Displays correct bus information', (
        WidgetTester tester,
      ) async {
        final testBus = {
          "name": "Test Bus",
          "route": "Test Route",
          "image": "assets/bus_a.png",
        };

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(), // Dummy home
            onGenerateRoute: (settings) {
              if (settings.name == '/bus') {
                return MaterialPageRoute(
                  builder: (context) => BusDetailScreen(),
                  settings: RouteSettings(name: '/bus', arguments: testBus),
                );
              }
              return MaterialPageRoute(builder: (context) => Scaffold());
            },
          ),
        );

        // Navigate to the detail screen
        Navigator.of(tester.element(find.byType(Scaffold))).pushNamed('/bus');
        await tester.pumpAndSettle();

        expect(find.text('Test Bus'), findsOneWidget);
        expect(find.text('Route: Test Route'), findsOneWidget);
      });

      testWidgets('Track on Map button works', (WidgetTester tester) async {
        final testBus = {
          "name": "Test Bus",
          "route": "Test Route",
          "image": "assets/bus_a.png",
        };

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(), // Dummy home
            routes: {'/map': (context) => Placeholder()},
            onGenerateRoute: (settings) {
              if (settings.name == '/bus') {
                return MaterialPageRoute(
                  builder: (context) => BusDetailScreen(),
                  settings: RouteSettings(name: '/bus', arguments: testBus),
                );
              }
              return MaterialPageRoute(builder: (context) => Scaffold());
            },
          ),
        );

        // Navigate to the detail screen
        Navigator.of(tester.element(find.byType(Scaffold))).pushNamed('/bus');
        await tester.pumpAndSettle();

        await tester.tap(find.text('Track on Map'));
        await tester.pumpAndSettle();

        expect(find.byType(Placeholder), findsOneWidget);
      });
    });

    // Utility tests
    group('Utility Function Tests', () {
      test('Color parsing works correctly', () {
        Color parseHex(String hexCode) {
          hexCode = hexCode.replaceAll('#', '');
          if (hexCode.length == 6) {
            hexCode = 'FF$hexCode';
          }
          return Color(int.parse(hexCode, radix: 16));
        }

        expect(parseHex('#4285F4'), equals(Color(0xFF4285F4)));
      });
    });
  });
}
