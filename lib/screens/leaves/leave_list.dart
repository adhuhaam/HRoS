import 'package:flutter/material.dart';
import 'package:officeos/constants/api.dart';
import 'package:officeos/services/api_service.dart';
import 'package:officeos/models/leave.dart';

class LeaveListPage extends StatefulWidget {
  const LeaveListPage({super.key});

  @override
  State<LeaveListPage> createState() => _LeaveListPageState();
}

class _LeaveListPageState extends State<LeaveListPage> {
  List<Leave> leaves = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchLeaves();
  }

  Future<void> fetchLeaves() async {
    final response = await ApiService.get(ApiConstants.leaveList);
    if (response != null && response['data'] != null) {
      setState(() {
        leaves = List<Leave>.from(response['data'].map((e) => Leave.fromJson(e)));
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Leave List")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: leaves.length,
        itemBuilder: (context, index) {
          final leave = leaves[index];
          return Card(
            child: ListTile(
              title: Text("${leave.type} (${leave.totalDays} days)"),
              subtitle: Text("${leave.startDate} → ${leave.endDate}"),
              trailing: Text(
                leave.status,
                style: TextStyle(
                  color: leave.status == 'Approved'
                      ? Colors.green
                      : leave.status == 'Rejected'
                      ? Colors.red
                      : Colors.orange,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
// leave_list.dart - placeholder for leaves