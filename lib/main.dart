import 'package:flutter/material.dart';
import 'package:nike_shop/data/repo/auth_repository.dart';
import 'package:nike_shop/theme.dart';
import 'package:nike_shop/ui/auth/auth_screen.dart';

import 'package:nike_shop/ui/root_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  authRepository.loadAuthToken();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nike Shop',
      theme: ThemeData(
        textTheme: const TextTheme(labelMedium: TextStyle(fontSize: 15)),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: LightThemeColors.secondaryColor),
        colorScheme: const ColorScheme.light(
          primary: LightThemeColors.primaryColor,
          secondary: LightThemeColors.secondaryColor,
          onSecondary: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const Directionality(
          textDirection: TextDirection.rtl, child: AuthScreen()),
    );
  }
}
