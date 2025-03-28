import 'package:flutter/material.dart';
import 'package:officeos/constants/api.dart';
import 'package:officeos/services/api_service.dart';
import 'package:officeos/models/notification.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<NotificationModel> notifications = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    final response = await ApiService.get(ApiConstants.notifications);
    if (response != null && response['data'] != null) {
      setState(() {
        notifications = List<NotificationModel>.from(
          response['data'].map((n) => NotificationModel.fromJson(n)),
        );
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final note = notifications[index];
          return ListTile(
            title: Text(note.title),
            subtitle: Text(note.message),
            trailing: Text(note.date, style: const TextStyle(fontSize: 12)),
          );
        },
      ),
    );
  }
}
// notifications.dart - placeholder for notifications