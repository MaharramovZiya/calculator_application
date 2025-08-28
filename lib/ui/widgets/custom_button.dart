import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType buttonType;
  final bool isWide;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonType = ButtonType.standard,
    this.isWide = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isWide ? 180 : 70,
      height: 70,
      margin: const EdgeInsets.all(3),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: _getButtonColor(context),
              boxShadow: _getBoxShadows(context),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: _getFontSize(),
                  fontWeight: FontWeight.w600,
                  color: _getTextColor(context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getButtonColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (buttonType) {
      case ButtonType.standard:
        return isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF5F5F5);
      case ButtonType.operator:
        return isDark ? const Color(0xFFE74C3C) : const Color(0xFFE74C3C);
      case ButtonType.function:
        return isDark ? const Color(0xFF3C3C3C) : const Color(0xFFE0E0E0);
      case ButtonType.clear:
        return isDark ? const Color(0xFFE74C3C) : const Color(0xFFE74C3C);
    }
  }

  Color _getTextColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (buttonType) {
      case ButtonType.standard:
        return isDark ? Colors.white : Colors.black;
      case ButtonType.operator:
        return Colors.white;
      case ButtonType.function:
        return isDark ? Colors.white : Colors.black;
      case ButtonType.clear:
        return Colors.white;
    }
  }

  List<BoxShadow> _getBoxShadows(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isDark) {
      return [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          offset: const Offset(4, 4),
          blurRadius: 8,
        ),
        BoxShadow(
          color: Colors.white.withOpacity(0.1),
          offset: const Offset(-2, -2),
          blurRadius: 8,
        ),
      ];
    } else {
      return [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          offset: const Offset(4, 4),
          blurRadius: 8,
        ),
        BoxShadow(
          color: Colors.white.withOpacity(0.8),
          offset: const Offset(-2, -2),
          blurRadius: 8,
        ),
      ];
    }
  }

  double _getFontSize() {
    if (text.length > 2) return 14;
    if (text.length > 1) return 18;
    return 22;
  }
}

enum ButtonType { standard, operator, function, clear }
