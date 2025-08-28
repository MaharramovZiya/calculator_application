import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/provider/calculator_provider.dart';
import 'custom_button.dart';

class CalculatorKeypad extends StatelessWidget {
  const CalculatorKeypad({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, calculatorProvider, child) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                // Scientific functions row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      text: 'π',
                      onPressed: () => calculatorProvider.addPi(),
                      buttonType: ButtonType.function,
                    ),
                    CustomButton(
                      text: '∫',
                      onPressed: () {
                        // Integral function placeholder
                      },
                      buttonType: ButtonType.function,
                    ),
                    CustomButton(
                      text: 'fₓ',
                      onPressed: () {
                        // Function x placeholder
                      },
                      buttonType: ButtonType.function,
                    ),
                    CustomButton(
                      text: 'LOG',
                      onPressed: () => calculatorProvider.addLog(),
                      buttonType: ButtonType.function,
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Main keypad
                Column(
                  children: [
                    // Row 1: AC, (), %, /
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                          text: 'AC',
                          onPressed: () => calculatorProvider.clearAll(),
                          buttonType: ButtonType.clear,
                        ),
                        CustomButton(
                          text: '()',
                          onPressed: () {
                            // Toggle parentheses
                            if (calculatorProvider.currentExpression.contains(
                              '(',
                            )) {
                              calculatorProvider.addParentheses(')');
                            } else {
                              calculatorProvider.addParentheses('(');
                            }
                          },
                          buttonType: ButtonType.function,
                        ),
                        CustomButton(
                          text: '%',
                          onPressed: () => calculatorProvider.addPercentage(),
                          buttonType: ButtonType.function,
                        ),
                        CustomButton(
                          text: '/',
                          onPressed: () => calculatorProvider.addOperator('/'),
                          buttonType: ButtonType.operator,
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Row 2: 7, 8, 9, X
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                          text: '7',
                          onPressed: () => calculatorProvider.addDigit('7'),
                        ),
                        CustomButton(
                          text: '8',
                          onPressed: () => calculatorProvider.addDigit('8'),
                        ),
                        CustomButton(
                          text: '9',
                          onPressed: () => calculatorProvider.addDigit('9'),
                        ),
                        CustomButton(
                          text: '×',
                          onPressed: () => calculatorProvider.addOperator('*'),
                          buttonType: ButtonType.operator,
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Row 3: 4, 5, 6, -
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                          text: '4',
                          onPressed: () => calculatorProvider.addDigit('4'),
                        ),
                        CustomButton(
                          text: '5',
                          onPressed: () => calculatorProvider.addDigit('5'),
                        ),
                        CustomButton(
                          text: '6',
                          onPressed: () => calculatorProvider.addDigit('6'),
                        ),
                        CustomButton(
                          text: '-',
                          onPressed: () => calculatorProvider.addOperator('-'),
                          buttonType: ButtonType.operator,
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Row 4: 1, 2, 3, +
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                          text: '1',
                          onPressed: () => calculatorProvider.addDigit('1'),
                        ),
                        CustomButton(
                          text: '2',
                          onPressed: () => calculatorProvider.addDigit('2'),
                        ),
                        CustomButton(
                          text: '3',
                          onPressed: () => calculatorProvider.addDigit('3'),
                        ),
                        CustomButton(
                          text: '+',
                          onPressed: () => calculatorProvider.addOperator('+'),
                          buttonType: ButtonType.operator,
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Row 5: 0, ., =
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                          text: '0',
                          onPressed: () => calculatorProvider.addDigit('0'),
                          isWide: true,
                        ),

                        CustomButton(
                          text: '.',
                          onPressed: () => calculatorProvider.addDigit('.'),
                        ),

                        CustomButton(
                          text: '=',
                          onPressed: () => calculatorProvider.calculate(),
                          buttonType: ButtonType.operator,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
