import 'package:flutter/material.dart';
import 'package:officeos/constants/api.dart';
import 'package:officeos/services/api_service.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final oldPass = TextEditingController();
  final newPass = TextEditingController();
  final confirmPass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String? message;

  Future<void> _changePassword() async {
    if (!_formKey.currentState!.validate()) return;
    if (newPass.text != confirmPass.text) {
      setState(() => message = "New passwords do not match");
      return;
    }

    setState(() => loading = true);

    final response = await ApiService.post(ApiConstants.changePassword, {
      "old_password": oldPass.text,
      "new_password": newPass.text,
    });

    setState(() {
      loading = false;
      message = response!['message'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change Password")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: oldPass,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Old Password"),
                validator: (val) => val == null || val.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: newPass,
                obscureText: true,
                decoration: const InputDecoration(labelText: "New Password"),
                validator: (val) => val == null || val.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: confirmPass,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Confirm Password"),
                validator: (val) => val == null || val.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 20),
              if (message != null)
                Text(message!,
                    style: const TextStyle(color: Colors.green)),
              ElevatedButton(
                onPressed: loading ? null : _changePassword,
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Change Password"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// change_password.dart - placeholder for profile