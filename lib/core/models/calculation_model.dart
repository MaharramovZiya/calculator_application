class CalculationModel {
  final String expression;
  final double result;
  final DateTime timestamp;
  final String operationType;

  CalculationModel({
    required this.expression,
    required this.result,
    required this.timestamp,
    required this.operationType,
  });

  Map<String, dynamic> toJson() {
    return {
      'expression': expression,
      'result': result,
      'timestamp': timestamp.toIso8601String(),
      'operationType': operationType,
    };
  }

  factory CalculationModel.fromJson(Map<String, dynamic> json) {
    return CalculationModel(
      expression: json['expression'],
      result: json['result'].toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
      operationType: json['operationType'],
    );
  }
}
