class Leave {
  final int leaveId;
  final String leaveType;
  final String startDate;
  final String endDate;
  final int numDays;
  final String? remarks;
  final String status;
  final String appliedDate;

  Leave({
    required this.leaveId,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.numDays,
    this.remarks,
    required this.status,
    required this.appliedDate,
  });

  factory Leave.fromJson(Map<String, dynamic> json) {
    return Leave(
      leaveId: json['leave_id'],
      leaveType: json['leave_type'], // "no Pay "
      startDate: json['start_date'],
      endDate: json['end_date'],
      numDays: json['num_days'],
      remarks: json['remarks'],
      status: json['status'],
      appliedDate: json['applied_date'],
    );
  }

}
