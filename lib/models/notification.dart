class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String date;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.date,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      date: json['date'] ?? '',
    );
  }
}
