import 'package:flutter/material.dart';
import 'package:officeos/screens/login/login_screen.dart';
import 'package:officeos/screens/dashboard/dashboard_screen.dart';
import 'package:officeos/utils/themes.dart';
import 'package:officeos/screens/leaves/leave_screen.dart';
import 'package:officeos/screens/notices/notice_screen.dart';
import 'package:officeos/screens/documents/document_screen.dart';
import 'package:officeos/screens/profile/profile_page.dart';
import 'package:officeos/screens/payslip/payslip_page.dart';
import 'package:officeos/screens/profile/edit_profile_page.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HROS',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/dashboard': (context) {
          final empNo = ModalRoute.of(context)!.settings.arguments as String;
          return DashboardScreen(empNo: empNo);
        },
        '/profile': (context) => const ProfilePage(),
        '/leaves': (context) => const LeaveScreen(),
        '/notices': (context) => const NoticeScreen(),
        '/documents': (context) => const DocumentScreen(),
        '/payslip': (context) => const PayslipPage(),
        '/edit-profile': (context) => const EditProfilePage(),


      },
    );
  }
}
