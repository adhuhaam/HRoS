import 'package:flutter/material.dart';

class NoticeScreen extends StatelessWidget {
  const NoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notices = [
      {
        'title': 'Leave Form Reminder',
        'body': 'All employees must submit their leave forms by 30th March.'
      },
      {
        'title': 'Eid Holiday Update',
        'body': 'Eid holidays will be announced next week. Stay tuned.'
      },
      {
        'title': 'New HR Policy',
        'body': 'A revised HR policy has been published. Check your email.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notices",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notices.length,
        itemBuilder: (context, index) {
          final notice = notices[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notice['title'] ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                Text(notice['body'] ?? ''),
              ],
            ),
          );
        },
      ),
    );
  }
}
