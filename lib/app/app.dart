import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/provider/provider_scope.dart';
import '../services/provider/calculator_provider.dart';
import '../ui/screens/calculator_screen.dart';

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer<CalculatorProvider>(
        builder: (context, calculatorProvider, child) {
          return MaterialApp(
            title: 'Calculator App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.light,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFFE74C3C),
                brightness: Brightness.light,
              ),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFFE74C3C),
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
            ),
            themeMode: calculatorProvider.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const CalculatorScreen(),
          );
        },
      ),
    );
  }
}
