import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:officeos/constants/Theme.dart';
import 'package:officeos/models/profile_data.dart';
import 'package:officeos/services/profile_service.dart';
import 'package:officeos/widgets/argon_drawer.dart';
import 'package:officeos/widgets/navbar.dart';

class ProfilePage extends StatelessWidget {
  final String empNo;

  const ProfilePage({super.key, required this.empNo});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : ArgonColors.bgColorScreen,
      drawer: ArgonDrawer(currentPage: "Profile", empNo: empNo),
      appBar: Navbar(
        title: "Profile",
        transparent: true,
        backButton: false,

      ),
      body: FutureBuilder<ProfileData>(
        future: ProfileService.fetchProfile(empNo),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data ?? ProfileData.empty();

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 6,
                    margin: const EdgeInsets.only(top: 80),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 90, bottom: 24),
                      child: Column(
                        children: [
                          _buttonRow(),
                          const SizedBox(height: 24),
                          _statsRow(data.leaveBalances),
                          const SizedBox(height: 28),
                          Text(
                            data.name,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : ArgonColors.text,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            data.designation,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: isDark ? Colors.grey[400] : ArgonColors.muted,
                            ),
                          ),
                          const Divider(height: 40, thickness: 1),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              data.address,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: isDark ? Colors.grey[300] : ArgonColors.text,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Documents",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    )),
                                Text("View All",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: ArgonColors.primary)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          _albumGrid(data.documentUrls),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    top: 0,
                    left: MediaQuery.of(context).size.width / 2 - 65,
                    child: CircleAvatar(
                      radius: 65,
                      backgroundImage: data.photoUrl.isNotEmpty
                          ? NetworkImage(data.photoUrl)
                          : const AssetImage("assets/images/avatar_placeholder.png")
                      as ImageProvider,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buttonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _actionButton("CONNECT", ArgonColors.info),
        const SizedBox(width: 20),
        _actionButton("MESSAGE", ArgonColors.initial),
      ],
    );
  }

  Widget _actionButton(String label, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: bgColor.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _statsRow(Map<String, String> balances) {
    if (balances.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(12),
        child: Text("No leave balances found"),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: balances.entries
          .map((entry) => _statColumn(entry.value, entry.key))
          .toList(),
    );
  }

  Widget _statColumn(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(205, 205, 205, 1.0),
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Color.fromRGBO(0, 107, 173, 1.0),
          ),
        ),
      ],
    );
  }

  Widget _albumGrid(List<String> urls) {
    if (urls.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text("No documents uploaded"),
      );
    }

    return SizedBox(
      height: 220,
      child: GridView.count(
        crossAxisCount: 3,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        primary: false,
        children: urls
            .map((url) => ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(url, fit: BoxFit.cover),
        ))
            .toList(),
      ),
    );
  }
}
