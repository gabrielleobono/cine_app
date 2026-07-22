import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:cine_app/screens/settings_screen.dart';
import 'package:cine_app/providers/theme_provider.dart';

void main() {
  testWidgets('SettingsScreen bascule le thème via le switch', (
    WidgetTester tester,
  ) async {
    final themeProvider = ThemeProvider();

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: themeProvider,
        child: const MaterialApp(home: SettingsScreen()),
      ),
    );

    expect(themeProvider.isDarkMode, false);

    await tester.tap(find.byType(Switch));
    await tester.pump();

    expect(themeProvider.isDarkMode, true);
  });
}
