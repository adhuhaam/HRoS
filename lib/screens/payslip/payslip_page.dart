import 'package:flutter/material.dart';
// ignore: unused_import
import  'package:officeos/utils/constants.dart';

class PayslipPage extends StatelessWidget {
  const PayslipPage({super.key}); //
  final String employeeName = "Mohamed Zayan";
  final String empNo = "EMP12345";
  final String month = "March";
  final String year = "2025";

  final double basicSalary = 10000;
  final double allowance = 2000;
  final double overtime = 1500;
  final double deductions = 1200;

  @override
  Widget build(BuildContext context) {
    double totalEarnings = basicSalary + allowance + overtime;
    double netPay = totalEarnings - deductions;

    return Scaffold(
      appBar: AppBar(
        title: Text("Payslip"),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text("$month $year Payslip",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),
                _buildRow("Employee Name", employeeName),
                _buildRow("Employee No.", empNo),
                Divider(thickness: 1),
                _buildRow("Basic Salary", "MVR ${basicSalary.toStringAsFixed(2)}"),
                _buildRow("Allowance", "MVR ${allowance.toStringAsFixed(2)}"),
                _buildRow("Overtime", "MVR ${overtime.toStringAsFixed(2)}"),
                Divider(thickness: 1),
                _buildRow("Total Earnings", "MVR ${totalEarnings.toStringAsFixed(2)}",
                    bold: true),
                _buildRow("Deductions", "MVR ${deductions.toStringAsFixed(2)}"),
                Divider(thickness: 1),
                _buildRow("Net Pay", "MVR ${netPay.toStringAsFixed(2)}",
                    bold: true, color: Colors.green[800]),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // PDF download / Share / View logic
                    },
                    icon: Icon(Icons.download),
                    label: Text("Download PDF"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value,
      {bool bold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                color: color ?? Colors.black87,
              )),
        ],
      ),
    );
  }
}
