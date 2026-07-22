import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'router/app_router.dart';
import 'providers/theme_provider.dart';
import 'providers/movie_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => MovieProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

// main.dart (Section MyApp modifiée)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final movieProvider = Provider.of<MovieProvider>(context);

    // Écran de chargement général si le JSON n'est pas encore prêt
    if (movieProvider.isLoading) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    // Écran d'erreur si le chargement du fichier JSON a échoué
    if (movieProvider.errorMessage.isNotEmpty) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Center(child: Text(movieProvider.errorMessage))),
      );
    }

    // L'application démarre normalement une fois les données chargées
    return MaterialApp.router(
      title: 'CinéScope',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}
