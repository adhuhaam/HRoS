import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:officeos/constants/api.dart';
import 'package:officeos/services/api_service.dart';

class ApplyLeavePage extends StatefulWidget {
  const ApplyLeavePage({super.key});

  @override
  State<ApplyLeavePage> createState() => _ApplyLeavePageState();
}

class _ApplyLeavePageState extends State<ApplyLeavePage> {
  final _formKey = GlobalKey<FormState>();
  final _typeController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _remarksController = TextEditingController();

  bool _submitting = false;
  String? _message;

  Future<void> _submitLeave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _submitting = true;
      _message = null;
    });

    final response = await ApiService.post(ApiConstants.applyLeave, {
      "type": _typeController.text,
      "start_date": _startDateController.text,
      "end_date": _endDateController.text,
      "remarks": _remarksController.text,
    });

    setState(() {
      _submitting = false;
      _message = response!['message'];
    });

    if (response!['status'] == 'success') {
      Navigator.pop(context);
    }
  }

  Future<void> _pickDate(TextEditingController controller) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDate: DateTime.now(),
    );

    if (date != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Apply for Leave")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: "Leave Type"),
                validator: (val) => val == null || val.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: _startDateController,
                decoration: const InputDecoration(labelText: "Start Date"),
                readOnly: true,
                onTap: () => _pickDate(_startDateController),
                validator: (val) => val == null || val.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: _endDateController,
                decoration: const InputDecoration(labelText: "End Date"),
                readOnly: true,
                onTap: () => _pickDate(_endDateController),
                validator: (val) => val == null || val.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: _remarksController,
                decoration: const InputDecoration(labelText: "Remarks"),
              ),
              const SizedBox(height: 20),
              if (_message != null)
                Text(_message!,
                    style: const TextStyle(color: Colors.green)),
              ElevatedButton(
                onPressed: _submitting ? null : _submitLeave,
                child: _submitting
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Submit Leave"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// apply_leave.dart - placeholder for leaves