import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';


class BiometricAuth {
  final LocalAuthentication auth = LocalAuthentication();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<bool> canCheckBiometrics() async {
    return await auth.canCheckBiometrics && await auth.isDeviceSupported();
  }

  Future<bool> authenticate() async {
    try {
      return await auth.authenticate(
        localizedReason: 'Login using fingerprint or face ID',
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } catch (e) {
      return false;
    }
  }

  Future<void> saveEmpNo(String empNo) async {
    await storage.write(key: 'biometric_emp', value: empNo);
  }

  Future<String?> getSavedEmpNo() async {
    return await storage.read(key: 'biometric_emp');
  }

  Future<void> clearBiometricLogin() async {
    await storage.delete(key: 'biometric_emp');
  }
}
