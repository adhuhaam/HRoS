// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
// ignore: unused_import
import  'package:officeos/utils/constants.dart'; // ✅ Your constants import



class LeaveScreen extends StatelessWidget {
  const LeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Leave", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: const TabBar(
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "Leave Balance"),
              Tab(text: "Leave History"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            LeaveBalanceTab(),
            LeaveListTab(),
          ],
        ),
      ),
    );
  }
}

class LeaveBalanceTab extends StatelessWidget {
  const LeaveBalanceTab({super.key});

  @override
  Widget build(BuildContext context) {
    final balances = [
      {'type': 'Annual Leave', 'balance': 12},
      {'type': 'Medical Leave', 'balance': 30},
      {'type': 'Emergency Leave', 'balance': 3},
      {'type': 'No Pay Leave', 'balance': 999},
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: balances.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final leave = balances[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.blue.shade100),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${leave['balance']} Days",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 6),
              Text(leave['type'] as String, textAlign: TextAlign.center),
            ],
          ),
        );
      },
    );
  }
}

class LeaveListTab extends StatelessWidget {
  const LeaveListTab({super.key});

  @override
  Widget build(BuildContext context) {
    final leaves = [
      {
        'type': 'Annual Leave',
        'start': '10-Mar-2025',
        'end': '20-Mar-2025',
        'status': 'Approved',
      },
      {
        'type': 'Medical Leave',
        'start': '05-Feb-2025',
        'end': '07-Feb-2025',
        'status': 'Pending',
      },
      {
        'type': 'Emergency Leave',
        'start': '22-Jan-2025',
        'end': '22-Jan-2025',
        'status': 'Rejected',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: leaves.length,
      itemBuilder: (context, index) {
        final leave = leaves[index];
        Color badgeColor = Colors.grey;
        if (leave['status'] == 'Approved') badgeColor = Colors.green;
        if (leave['status'] == 'Pending') badgeColor = Colors.orange;
        if (leave['status'] == 'Rejected') badgeColor = Colors.red;

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: badgeColor.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black12)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Text(leave['type'] as String),
              const SizedBox(height: 6),
              Text("Leave Type",
            style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 6),
              Text("From: ${leave['start']}"),
              Text("To: ${leave['end']}"),
              const SizedBox(height: 8),
              Chip(label: Text(leave['status'] ?? '')),
            ],
          ),
        );
      },
    );
  }
}
