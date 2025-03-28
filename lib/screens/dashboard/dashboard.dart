import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:officeos/widgets/argon_drawer.dart';
import 'package:officeos/widgets/navbar.dart';
import 'package:officeos/constants/Theme.dart';

class DashboardPage extends StatelessWidget {
  final String empNo;

  const DashboardPage({super.key, required this.empNo});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.white70 : Colors.black54;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : ArgonColors.bgColorScreen,
      drawer: ArgonDrawer(currentPage: "Home", empNo: empNo),
      appBar: const Navbar(
        title: "Dashboard",
        backButton: false,
        transparent: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                Text(
                  "Welcome, $empNo",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Access your profile, leave status, documents and more.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: subTextColor,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 40),
                // You can add animated tiles or cards here
              ],
            ),
          ),
        ),
      ),
    );
  }
}
