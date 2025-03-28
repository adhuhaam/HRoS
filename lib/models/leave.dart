class Leave {
  final String id;
  final String type;
  final String startDate;
  final String endDate;
  final int totalDays;
  final String status;
  final String remarks;

  Leave({
    required this.id,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.totalDays,
    required this.status,
    required this.remarks,
  });

  factory Leave.fromJson(Map<String, dynamic> json) {
    return Leave(
      id: json['id'].toString(),
      type: json['type'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      totalDays: int.tryParse(json['total_days'].toString()) ?? 0,
      status: json['status'] ?? '',
      remarks: json['remarks'] ?? '',
    );
  }
}
// leave.dart - placeholder for models