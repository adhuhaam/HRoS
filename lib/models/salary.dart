class Salary {
  final String month;
  final double basic;
  final double allowance;
  final double deduction;
  final double netPay;

  Salary({
    required this.month,
    required this.basic,
    required this.allowance,
    required this.deduction,
    required this.netPay,
  });

  factory Salary.fromJson(Map<String, dynamic> json) {
    return Salary(
      month: json['month'] ?? '',
      basic: double.tryParse(json['basic'].toString()) ?? 0.0,
      allowance: double.tryParse(json['allowance'].toString()) ?? 0.0,
      deduction: double.tryParse(json['deduction'].toString()) ?? 0.0,
      netPay: double.tryParse(json['net_pay'].toString()) ?? 0.0,
    );
  }
}
