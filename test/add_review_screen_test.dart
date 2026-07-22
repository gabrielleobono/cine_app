import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cine_app/screens/add_review_screen.dart';

void main() {
  testWidgets(
    'AddReviewScreen affiche des erreurs si on soumet un formulaire vide',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AddReviewScreen(movieId: 'm1', movieTitle: 'Test Movie'),
        ),
      );

      await tester.tap(find.text('Envoyer mon avis'));
      await tester.pump();

      expect(find.text('Nom trop court (min 2 caractères)'), findsOneWidget);
      expect(find.text('Veuillez choisir une note'), findsOneWidget);
      expect(
        find.text('Commentaire trop court (min 10 caractères)'),
        findsOneWidget,
      );
    },
  );
}
