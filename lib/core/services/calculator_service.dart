import 'dart:math';
import '../models/calculation_model.dart';

class CalculatorService {
  static final CalculatorService _instance = CalculatorService._internal();
  factory CalculatorService() => _instance;
  CalculatorService._internal();

  // Security: Input validation and sanitization
  bool _isValidInput(String input) {
    // Only allow valid mathematical characters
    final validPattern = RegExp(r'^[0-9+\-*/().\s]+$');
    return validPattern.hasMatch(input) && input.isNotEmpty;
  }

  // Security: Prevent division by zero and other dangerous operations
  bool _isSafeOperation(String expression) {
    if (expression.contains('/0')) return false;
    if (expression.contains('**')) return false; // Prevent power operations
    return true;
  }

  // Calculate result with security checks
  double? calculate(String expression) {
    try {
      // Security: Validate input
      if (!_isValidInput(expression)) {
        throw Exception('Invalid input detected');
      }

      // Security: Check for dangerous operations
      if (!_isSafeOperation(expression)) {
        throw Exception('Unsafe operation detected');
      }

      // Clean expression and evaluate
      final cleanExpression = expression.replaceAll(' ', '');
      final result = _evaluateExpression(cleanExpression);

      return result;
    } catch (e) {
      // Log error for security monitoring
      _logError('Calculation error: $e', expression);
      return null;
    }
  }

  // Safe expression evaluation
  double _evaluateExpression(String expression) {
    try {
      // Simple evaluation for basic operations
      if (expression.contains('+') ||
          expression.contains('-') ||
          expression.contains('*') ||
          expression.contains('/')) {
        return _evaluateSimpleExpression(expression);
      }

      // If it's just a number, return it
      return double.parse(expression);
    } catch (e) {
      throw Exception('Invalid expression: $expression');
    }
  }

  // Simple expression evaluation
  double _evaluateSimpleExpression(String expression) {
    // Handle multiplication and division first (PEMDAS rule)
    if (expression.contains('*') || expression.contains('/')) {
      expression = _evaluateMultiplicationDivision(expression);
    }

    // Handle addition and subtraction
    if (expression.contains('+') || expression.contains('-')) {
      expression = _evaluateAdditionSubtraction(expression);
    }

    return double.parse(expression);
  }

  String _evaluateMultiplicationDivision(String expression) {
    // Find first * or / operation
    final regex = RegExp(r'(\d+\.?\d*)\s*([*/])\s*(\d+\.?\d*)');
    var result = expression;

    while (regex.hasMatch(result)) {
      final match = regex.firstMatch(result)!;
      final left = double.parse(match.group(1)!);
      final operator = match.group(2)!;
      final right = double.parse(match.group(3)!);

      double calculated;
      if (operator == '*') {
        calculated = left * right;
      } else {
        if (right == 0) throw Exception('Division by zero');
        calculated = left / right;
      }

      result = result.replaceFirst(match.group(0)!, calculated.toString());
    }

    return result;
  }

  String _evaluateAdditionSubtraction(String expression) {
    // Find first + or - operation
    final regex = RegExp(r'(\d+\.?\d*)\s*([+-])\s*(\d+\.?\d*)');
    var result = expression;

    while (regex.hasMatch(result)) {
      final match = regex.firstMatch(result)!;
      final left = double.parse(match.group(1)!);
      final operator = match.group(2)!;
      final right = double.parse(match.group(3)!);

      final calculated = operator == '+' ? left + right : left - right;
      result = result.replaceFirst(match.group(0)!, calculated.toString());
    }

    return result;
  }

  // Scientific functions
  double calculatePi() => pi;

  double calculateLog(double number) {
    if (number <= 0) throw Exception('Invalid input for logarithm');
    return log(number) / ln10;
  }

  double calculateIntegral(double a, double b, Function(double) f) {
    // Simple numerical integration using trapezoidal rule
    const n = 1000;
    final h = (b - a) / n;
    double sum = (f(a) + f(b)) / 2;

    for (int i = 1; i < n; i++) {
      sum += f(a + i * h);
    }

    return sum * h;
  }

  // Logging for security and monitoring
  void _logError(String error, String input) {
    // In production, this would send to a logging service
    print('SECURITY_LOG: $error | Input: $input | Time: ${DateTime.now()}');
  }

  // Create calculation model for logging
  CalculationModel createCalculationLog(
    String expression,
    double result,
    String operationType,
  ) {
    return CalculationModel(
      expression: expression,
      result: result,
      timestamp: DateTime.now(),
      operationType: operationType,
    );
  }
}
