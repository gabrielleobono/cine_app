import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:cine_app/screens/home_screen.dart';
import 'package:cine_app/providers/movie_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('HomeScreen affiche le titre et une barre de recherche', (
    WidgetTester tester,
  ) async {
    // Simule la lecture du fichier JSON pour le MovieProvider
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('flutter/assets'), (
          MethodCall methodCall,
        ) async {
          return '[{"id":"m1","title":"Blade Runner","genre":"Science-Fiction","year":1982,"rating":4.5,"durationMinutes":132,"director":"Ridley Scott","synopsis":"Futur.","posterEmoji":"🤖","colorValue":4281944507}]';
        });

    // Initialisation du provider qui va appeler l'initialisation du repository mocké
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => MovieProvider(),
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    // Laisse le temps au Future asynchrone de se résoudre et de notifier l'UI
    await tester.pumpAndSettle();

    // Assertions
    expect(find.text('CinéScope'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(Card), findsWidgets);
  });
}
