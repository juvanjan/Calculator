import 'package:calculator/views/calculator.dart';
import 'package:calculator/data_access/data_access.dart';
import 'package:flutter/material.dart';

void main() {
  DataAccess().preloadCurrencies();
  runApp(const CalculatorApplication());
}

class CalculatorApplication extends StatelessWidget {
  const CalculatorApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme(
          primary: Colors.white,
          secondary: Colors.deepOrangeAccent,
          surface: Colors.white30,
          background: Colors.white70,
          error: Colors.red,
          onPrimary: Colors.black,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.redAccent,
          brightness: Brightness.light,
        )
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme(
          primary: Colors.black,
          secondary: Colors.deepOrangeAccent,
          surface: Colors.black38,
          background: Colors.black45,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          onBackground: Colors.white,
          onError: Colors.redAccent,
          brightness: Brightness.dark,
        )
      ), // standard dark theme
      themeMode: ThemeMode.system,
      home: const Calculator(),
    );
  }
}