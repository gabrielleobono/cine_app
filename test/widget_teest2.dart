import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cine_app/screens/home_screen.dart';

void main() {
  testWidgets('HomeScreen affiche le titre et une barre de recherche', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // le titre CinéScope doit apparaître
    expect(find.text('CinéScope'), findsOneWidget);

    // la barre de recherche doit être présente
    expect(find.byType(TextField), findsOneWidget);

    // au moins une carte de film doit s'afficher
    expect(find.byType(Card), findsWidgets);
  });
}
