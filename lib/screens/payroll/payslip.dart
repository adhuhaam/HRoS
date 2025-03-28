import 'package:flutter/material.dart';
import 'package:officeos/constants/api.dart';
import 'package:officeos/services/api_service.dart';

class PayslipPage extends StatefulWidget {
  const PayslipPage({super.key});

  @override
  State<PayslipPage> createState() => _PayslipPageState();
}

class _PayslipPageState extends State<PayslipPage> {
  Map<String, dynamic>? payslip;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchPayslip();
  }

  Future<void> fetchPayslip() async {
    final response = await ApiService.get(ApiConstants.payslip);
    if (response != null && response['data'] != null) {
      setState(() {
        payslip = response['data'];
        loading = false;
      });
    }
  }

  Widget _buildItem(String label, dynamic value) {
    return ListTile(
      title: Text(label),
      trailing: Text(value.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payslip")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
        padding: const EdgeInsets.all(10),
        children: [
          _buildItem("Month", payslip!['month']),
          _buildItem("Basic Salary", payslip!['basic']),
          _buildItem("Allowances", payslip!['allowance']),
          _buildItem("Deductions", payslip!['deduction']),
          const Divider(),
          _buildItem("Net Pay", payslip!['net_pay']),
        ],
      ),
    );
  }
}
// payslip.dart - placeholder for payroll