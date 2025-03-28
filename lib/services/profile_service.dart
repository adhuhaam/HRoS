import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:officeos/models/profile_data.dart';

class ProfileService {
  static const String baseUrl = 'https://hros.rccmaldives.com/api';

  static Future<ProfileData> fetchProfile(String empNo) async {
    try {
      final employeeRes = await http.get(Uri.parse('$baseUrl/employee/index.php?emp_no=$empNo'));
      final docRes = await http.get(Uri.parse('$baseUrl/document/index.php?emp_no=$empNo'));
      final leaveRes = await http.get(Uri.parse('$baseUrl/leave_balance.php?emp_no=$empNo'));

      if (employeeRes.statusCode != 200 || docRes.statusCode != 200 || leaveRes.statusCode != 200) {
        throw Exception('Failed to fetch data');
      }

      final employeeData = json.decode(employeeRes.body);
      final docData = json.decode(docRes.body);
      final leaveData = json.decode(leaveRes.body);

      final emp = employeeData['data'];
      final docs = docData['data'] as List;
      final photo = docs.firstWhere((d) => d['doc_type'] == 'Photo', orElse: () => null);

      return ProfileData(
        name: emp['name'] ?? 'N/A',
        designation: emp['designation_name'] ?? 'N/A',
        address: emp['present_address'] ?? 'N/A',
        photoUrl: photo != null
            ? "https://hros.rccmaldives.com/assets/document/${photo['photo_file_name']}"
            : '',
        leaveBalances: {
          for (var b in leaveData['balances']) b['leave_type']: b['balance'].toString()
        },
        documentUrls: docs
            .map<String>((d) => "https://hros.rccmaldives.com/assets/document/${d['front_file_name']}")
            .toList(),
      );
    } catch (e) {
      print("Error fetching profile: $e");
      return ProfileData.empty();
    }
  }
}
