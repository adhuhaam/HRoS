class ApiConstants {
  // Base URL
  static const String baseUrl = "https://hros.rccmaldives.com/api/";

  // Authentication
  static const String login = "${baseUrl}auth/index.php";

  // Employee
  static const String getEmployeeDetails = "${baseUrl}employees/index.php";
  static const String updateProfile = "${baseUrl}employees/update_profile.php";

  // Leaves
  static const String leaveList = "${baseUrl}leaves/index.php";
  static const String applyLeave = "${baseUrl}leaves/index.php";
  static const String leaveBalance = "${baseUrl}leaves/balances.php";

  // Payroll
  static const String salaryDetails = "${baseUrl}payslip/index.php";
  static const String payslip = "${baseUrl}payslip/index.php";

  // Notifications
  static const String notifications = "${baseUrl}notifications/list.php";

  // Documents
  static const String employeeDocuments = "${baseUrl}document/index.php";

  // Change Password
  static const String changePassword = "${baseUrl}auth/change_password.php";
}
