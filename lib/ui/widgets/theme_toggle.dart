import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/provider/calculator_provider.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, calculatorProvider, child) {
        return Container(
          margin: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // App title
              Text(
                'Calculator',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),

              // Theme toggle button
              GestureDetector(
                onTap: () => calculatorProvider.toggleTheme(),
                child: Container(
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: calculatorProvider.isDarkMode
                        ? const Color(0xFF2C2C2C)
                        : const Color(0xFFE0E0E0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Toggle indicator
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 200),
                        left: calculatorProvider.isDarkMode ? 32 : 2,
                        top: 2,
                        child: Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: calculatorProvider.isDarkMode
                                ? Colors.white
                                : Colors.orange,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0, 1),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Icon(
                            calculatorProvider.isDarkMode
                                ? Icons.dark_mode
                                : Icons.light_mode,
                            size: 16,
                            color: calculatorProvider.isDarkMode
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
