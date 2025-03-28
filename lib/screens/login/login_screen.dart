// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:officeos/utils/constants.dart';
import 'package:officeos/utils/themes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();

  bool isLoading = false;
  bool obscureText = true;
  String? errorMessage;
  bool biometricEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricEnabled();
  }

  Future<void> _checkBiometricEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    final enabled = prefs.getBool('biometric_enabled') ?? false;

    final isSupported = await auth.isDeviceSupported();
    final canCheckBiometrics = await auth.canCheckBiometrics;

    setState(() {
      biometricEnabled = enabled && isSupported && canCheckBiometrics;
    });
  }

  Future<void> login({bool save = true}) async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await http.post(
        Uri.parse(AppConstants.authApi),
        body: {
          'username': usernameController.text.trim(),
          'password': passwordController.text,
        },
      );

      final result = json.decode(response.body);
      if (result['status'] == 'success') {
        final empData = result['data'];
        final prefs = await SharedPreferences.getInstance();
        if (save) {
          await prefs.setString('emp_no', empData['emp_no']);
          await prefs.setString('username', usernameController.text.trim());
          await prefs.setString('password', passwordController.text);
        }

        if (context.mounted) {
          _promptEnableBiometric();
          Navigator.pushReplacementNamed(context, '/dashboard', arguments: empData['emp_no']);
        }
      } else {
        setState(() => errorMessage = result['message'] ?? 'Login failed');
      }
    } catch (_) {
      setState(() => errorMessage = "Connection error. Try again.");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> biometricLogin() async {
    try {
      final isSupported = await auth.isDeviceSupported();
      final canCheckBiometrics = await auth.canCheckBiometrics;

      if (!isSupported || !canCheckBiometrics) return;

      final authenticated = await auth.authenticate(
        localizedReason: 'Scan biometric to login',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );

      if (authenticated) {
        final prefs = await SharedPreferences.getInstance();
        final savedUsername = prefs.getString('username');
        final savedPassword = prefs.getString('password');

        if (savedUsername != null && savedPassword != null) {
          usernameController.text = savedUsername;
          passwordController.text = savedPassword;
          login(save: false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No saved login. Login manually.")),
          );
        }
      }
    } catch (e) {
      debugPrint("Biometric error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Biometric error: $e")),
      );
    }
  }

  Future<void> _promptEnableBiometric() async {
    final prefs = await SharedPreferences.getInstance();
    final alreadyEnabled = prefs.getBool('biometric_enabled') ?? false;

    if (alreadyEnabled) return;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Enable Biometric Login?"),
        content: const Text("Would you like to enable biometric login for future logins?"),
        actions: [
          TextButton(
            onPressed: () async {
              await prefs.setBool('biometric_enabled', false);
              Navigator.pop(ctx);
            },
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () async {
              await prefs.setBool('biometric_enabled', true);
              Navigator.pop(ctx);
              if (mounted) setState(() => biometricEnabled = true);
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDEF),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              children: [
                // Logo
                Column(
                  children: [
                    Image.asset('assets/images/logo.png', height: 70),
                    const SizedBox(height: 12),
                    Text(
                      "Welcome to OfficeOS",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Please sign in to continue",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Card
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            labelText: "Employee No",
                            prefixIcon: const Icon(Icons.badge),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: passwordController,
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureText ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        if (errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Text(errorMessage!,
                                style: const TextStyle(color: Colors.red)),
                          ),
                        const SizedBox(height: 28),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : () => login(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primary,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (biometricEnabled)
                          ElevatedButton.icon(
                            onPressed: biometricLogin,
                            icon: const Icon(Icons.fingerprint, size: 24),
                            label: const Text("Login with X"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppTheme.primary,
                              elevation: 1,
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              side: BorderSide(color: AppTheme.primary, width: 1.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
