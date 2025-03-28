import 'package:flutter/material.dart';
import 'package:officeos/constants/api.dart';
import 'package:officeos/services/api_service.dart';

class LeaveBalancePage extends StatefulWidget {
  const LeaveBalancePage({super.key});

  @override
  State<LeaveBalancePage> createState() => _LeaveBalancePageState();
}

class _LeaveBalancePageState extends State<LeaveBalancePage> {
  Map<String, dynamic> balances = {};
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchLeaveBalance();
  }

  Future<void> fetchLeaveBalance() async {
    final response = await ApiService.get(ApiConstants.leaveBalance);
    if (response != null && response['data'] != null) {
      setState(() {
        balances = response['data'];
        loading = false;
      });
    }
  }

  Widget _buildBalanceTile(String type, dynamic value) {
    return Card(
      child: ListTile(
        title: Text(type),
        trailing: Text(
          value.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Leave Balance")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
        padding: const EdgeInsets.all(10),
        children: balances.entries
            .map((e) => _buildBalanceTile(e.key, e.value))
            .toList(),
      ),
    );
  }
}
// leave_balance.dart - placeholder for leaves