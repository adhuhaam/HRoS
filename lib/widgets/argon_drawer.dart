import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:officeos/constants/Theme.dart';
import 'package:provider/provider.dart';
import 'package:officeos/constants/api.dart';
import 'package:officeos/theme/theme_notifier.dart';

class ArgonDrawer extends StatelessWidget {
  final String currentPage;
  final String empNo;

  const ArgonDrawer({super.key, required this.currentPage, required this.empNo});

  _launchURL() async {
    const url = 'https://hros.rccmaldives.com';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget buildDrawerTile({
    required BuildContext context,
    required String title,
    required IconData icon,
    required String route,
    required bool isSelected,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? Colors.white : Colors.black;
    final textColor = isDark ? Colors.white : ArgonColors.kalhu;

    return GestureDetector(
      onTap: () {
        if (currentPage != title) {
          Navigator.pushReplacementNamed(
            context,
            route,
            arguments: empNo,
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? ArgonColors.kalhu : Colors.blueAccent)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: isSelected ? Colors.white : iconColor),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : textColor,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      child: Container(
        color: isDark ? Colors.black : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                isDark
                    ? "assets/images/dark_logo.png"
                    : "assets/images/logo.png",
                height: 40,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  buildDrawerTile(
                    context: context,
                    title: "Home",
                    icon: Icons.home,
                    route: '/dashboard',
                    isSelected: currentPage == "Home",
                  ),
                  buildDrawerTile(
                    context: context,
                    title: "Profile",
                    icon: Icons.person,
                    route: '/profile',
                    isSelected: currentPage == "Profile",
                  ),
                  buildDrawerTile(
                    context: context,
                    title: "Leaves",
                    icon: Icons.airplane_ticket,
                    route: '/leaves',
                    isSelected: currentPage == "Leaves",
                  ),
                  buildDrawerTile(
                    context: context,
                    title: "Payroll",
                    icon: Icons.attach_money,
                    route: '/payroll',
                    isSelected: currentPage == "Payroll",
                  ),
                  buildDrawerTile(
                    context: context,
                    title: "Documents",
                    icon: Icons.document_scanner,
                    route: '/documents',
                    isSelected: currentPage == "Documents",
                  ),
                  buildDrawerTile(
                    context: context,
                    title: "Notices",
                    icon: Icons.notifications,
                    route: '/notifications',
                    isSelected: currentPage == "Notices",
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
