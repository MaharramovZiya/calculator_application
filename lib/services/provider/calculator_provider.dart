import 'package:flutter/foundation.dart';
import '../../core/models/calculation_model.dart';
import '../../core/services/calculator_service.dart';

class CalculatorProvider extends ChangeNotifier {
  final CalculatorService _calculatorService = CalculatorService();

  String _currentExpression = '';
  String _displayValue = '0';
  bool _isDarkMode = false;
  final List<CalculationModel> _calculationHistory = [];
  String _lastOperation = '';

  // Getters
  String get currentExpression => _currentExpression;
  String get displayValue => _displayValue;
  bool get isDarkMode => _isDarkMode;
  List<CalculationModel> get calculationHistory => _calculationHistory;
  String get lastOperation => _lastOperation;

  // Toggle theme
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  // Add digit to expression
  void addDigit(String digit) {
    if (_displayValue == '0' && digit != '.') {
      _currentExpression += digit;
      _displayValue = digit;
    } else {
      _currentExpression += digit;
      _displayValue += digit;
    }
    notifyListeners();
  }

  // Add operator
  void addOperator(String operator) {
    if (_currentExpression.isNotEmpty &&
        !_currentExpression.endsWith('+') &&
        !_currentExpression.endsWith('-') &&
        !_currentExpression.endsWith('*') &&
        !_currentExpression.endsWith('/') &&
        !_currentExpression.endsWith('(') &&
        !_currentExpression.endsWith('.')) {
      _currentExpression += operator;
      _displayValue = _currentExpression; // <<< düzəliş
      _lastOperation = operator;
    }
    notifyListeners();
  }

  // Add parentheses
  void addParentheses(String parenthesis) {
    if (parenthesis == '(') {
      if (_currentExpression.isNotEmpty &&
          !_currentExpression.endsWith('+') &&
          !_currentExpression.endsWith('-') &&
          !_currentExpression.endsWith('*') &&
          !_currentExpression.endsWith('/') &&
          !_currentExpression.endsWith('(')) {
        _currentExpression += '*(';
      } else {
        _currentExpression += '(';
      }
    } else {
      if (_currentExpression.isNotEmpty &&
          !_currentExpression.endsWith('+') &&
          !_currentExpression.endsWith('-') &&
          !_currentExpression.endsWith('*') &&
          !_currentExpression.endsWith('/') &&
          !_currentExpression.endsWith('(') &&
          !_currentExpression.endsWith('.')) {
        _currentExpression += ')';
      }
    }
    _displayValue = '0';
    notifyListeners();
  }

  // Add percentage
  void addPercentage() {
    if (_currentExpression.isNotEmpty &&
        !_currentExpression.endsWith('+') &&
        !_currentExpression.endsWith('-') &&
        !_currentExpression.endsWith('*') &&
        !_currentExpression.endsWith('/') &&
        !_currentExpression.endsWith('(') &&
        !_currentExpression.endsWith('.')) {
      try {
        final lastNumber = _getLastNumber();
        final percentage = double.parse(lastNumber) / 100;
        _currentExpression =
            _currentExpression.substring(
              0,
              _currentExpression.length - lastNumber.length,
            ) +
            percentage.toString();
        _displayValue = percentage.toString();
      } catch (e) {
        // Handle error
      }
    }
    notifyListeners();
  }

  // Get last number from expression
  String _getLastNumber() {
    final regex = RegExp(r'(\d+\.?\d*)$');
    final match = regex.firstMatch(_currentExpression);
    return match?.group(1) ?? '';
  }

  void calculate() {
    if (_currentExpression.isNotEmpty) {
      try {
        print("DEBUG: Current Expression = $_currentExpression");
        final result = _calculatorService.calculate(_currentExpression);
        print("DEBUG: Result from service = $result");

        if (result != null) {
          final calculationLog = _calculatorService.createCalculationLog(
            _currentExpression,
            result,
            _lastOperation.isEmpty ? 'calculation' : _lastOperation,
          );
          _calculationHistory.add(calculationLog);

          _displayValue = result.toString();
          _currentExpression = result.toString();
          _lastOperation = '';
        } else {
          _displayValue = 'Error';
        }
      } catch (e) {
        _displayValue = 'Error';
        print("DEBUG: Exception = $e");
      }
    }
    notifyListeners();
  }

  // Clear all
  void clearAll() {
    _currentExpression = '';
    _displayValue = '0';
    _lastOperation = '';
    notifyListeners();
  }

  // Clear last entry
  void clearLastEntry() {
    if (_currentExpression.isNotEmpty) {
      _currentExpression = _currentExpression.substring(
        0,
        _currentExpression.length - 1,
      );
      if (_currentExpression.isEmpty) {
        _displayValue = '0';
      } else {
        _displayValue = _currentExpression;
      }
    }
    notifyListeners();
  }

  // Scientific functions
  void addPi() {
    final piValue = _calculatorService.calculatePi();
    _currentExpression += piValue.toString();
    _displayValue = '0';
    notifyListeners();
  }

  void addLog() {
    if (_currentExpression.isNotEmpty &&
        !_currentExpression.endsWith('+') &&
        !_currentExpression.endsWith('-') &&
        !_currentExpression.endsWith('*') &&
        !_currentExpression.endsWith('/') &&
        !_currentExpression.endsWith('(') &&
        !_currentExpression.endsWith('.')) {
      try {
        final lastNumber = double.parse(_getLastNumber());
        final logResult = _calculatorService.calculateLog(lastNumber);
        _currentExpression =
            _currentExpression.substring(
              0,
              _currentExpression.length - lastNumber.toString().length,
            ) +
            logResult.toString();
        _displayValue = '0';
      } catch (e) {
        _displayValue = 'Error';
      }
    }
    notifyListeners();
  }

  // Clear history
  void clearHistory() {
    _calculationHistory.clear();
    notifyListeners();
  }
}
