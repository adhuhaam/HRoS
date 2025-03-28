import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatelessWidget {
  final String empNo;

  const DashboardScreen({super.key, required this.empNo});

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Dashboard",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () => logout(context),
            icon: const Icon(Icons.logout_rounded, color: Colors.red),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildWelcomeCard(),
            const SizedBox(height: 20),
            _buildQuickAccessRow(context),
            const SizedBox(height: 20),
            _buildAttendanceCard(),
            const SizedBox(height: 20),
            _buildBirthdaySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/avatar_placeholder.png'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Emp No: $empNo",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const Text("Welcome back!"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQuickAccessRow(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _quickTile(context, Icons.person, "Profile" , route: '/profile'),
            _quickTile(context, Icons.notifications, "Notices", route: '/notices'),
            _quickTile(context, Icons.warning, "Warnings"),
          ],
        ),
        SizedBox(height: 10), // space between rows
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _quickTile(context, Icons.access_time, "Leaves", route: '/leaves'),
            _quickTile(context, Icons.folder, "Documents", route: '/documents'),
            // Add another tile or leave empty for spacing
            Spacer(),
          ],
        ),
      ],
    );
  }


  Widget _quickTile(BuildContext context, IconData icon, String label, {String? route}) {
    return Expanded(
      child: GestureDetector(
        onTap: route != null
            ? () => Navigator.pushNamed(context, route)
            : () => debugPrint("Open: $label"),
        child: Container(
          height: 90,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(blurRadius: 6, color: Colors.black12)],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.blueAccent, size: 24),
              const SizedBox(height: 8),
              Text(label,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttendanceCard() {
    return Container(

      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Today's Attendance",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text("Check-in: 08:45 AM"),
          Text("Check-out: 05:15 PM"),
          Text("Status: Present"),
        ],
      ),
    );
  }

  Widget _buildBirthdaySection() {
    final birthdays = [
      {'name': 'Ali Rasheed', 'date': '24-Mar'},
      {'name': 'Zahira Ahmed', 'date': '26-Mar'},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("🎂 Upcoming Birthdays",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...birthdays.map((b) => ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.cake_outlined, color: Colors.pink),
            title: Text(b['name']!),
            subtitle: Text("🎉 ${b['date']}"),
          )),
        ],
      ),
    );
  }
}
