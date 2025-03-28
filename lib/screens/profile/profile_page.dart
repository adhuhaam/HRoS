import 'package:flutter/material.dart';
// ignore: unused_import
import  'package:officeos/utils/constants.dart';



class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  final String name = "Mohamed Zayan";
  final String designation = "Software Engineer";
  final String department = "IT Department";
  final String email = "zayan@rccmaldives.com";
  final String phone = "+960 9876543";
  final String empNo = "EMP12345";
  final String joinDate = "12-Mar-2021";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/avatar_placeholder.png'),
            ),
            const SizedBox(height: 12),
            Text(name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(designation, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
            Text(department, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.email, color: Colors.blue),
                    title: Text("Email"),
                    subtitle: Text(email),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.phone, color: Colors.green),
                    title: Text("Phone"),
                    subtitle: Text(phone),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.badge, color: Colors.orange),
                    title: Text("Employee No."),
                    subtitle: Text(empNo),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.calendar_today, color: Colors.purple),
                    title: Text("Date of Join"),
                    subtitle: Text(joinDate),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to edit profile page or enable editing
              },
              icon: Icon(Icons.edit),
              label: TextButton(
                onPressed: () => Navigator.pushNamed(context, '/edit-profile'),
                child: Text("Edit Profile", style: TextStyle(color: Colors.blue)),
              ),

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
