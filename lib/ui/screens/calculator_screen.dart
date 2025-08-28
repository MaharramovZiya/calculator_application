import 'package:flutter/material.dart';
import '../widgets/theme_toggle.dart';
import '../widgets/calculator_display.dart';
import '../widgets/calculator_keypad.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF1A1A1A)
                  : const Color(0xFFF8F9FA),
              Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF2C2C2C)
                  : const Color(0xFFE9ECEF),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Theme toggle and title
              const ThemeToggle(),

              // Calculator display
              const CalculatorDisplay(),

              // Calculator keypad
              const Expanded(child: CalculatorKeypad()),

              // Bottom padding
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
