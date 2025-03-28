class AppConstants {
  // Base URL
  static const String baseUrl = 'https://hros.rccmaldives.com/api/';

  // Auth
  static const String authApi = '${baseUrl}auth/index.php';

  // Employee documents
  static const String documentApi = '${baseUrl}document/index.php';

  // Warnings
  static const String warningApi = '${baseUrl}warning/';

  // Notices (future use)
  static const String noticesApi = '${baseUrl}notices/index.php';

  // Leave records
  static const String leaveListApi = '${baseUrl}leaves/list.php';
  static const String leaveBalanceApi = '${baseUrl}leaves/balance.php';

  // Apply Leave (if needed later)
  static const String applyLeaveApi = '${baseUrl}leaves/apply.php';

  // Change login credentials (username/password)
  static const String changeLoginApi = '${baseUrl}auth/change_credentials.php';

  // Profile info
  static const String profileApi = '${baseUrl}employee/profile.php';

  // Chat / Social wall (future)
  static const String wallApi = '${baseUrl}social/wall.php';
  static const String chatApi = '${baseUrl}social/chat.php';
}
