class ProfileData {
  final String name;
  final String designation;
  final String address;
  final String photoUrl;
  final Map<String, String> leaveBalances;
  final List<String> documentUrls;

  ProfileData({
    required this.name,
    required this.designation,
    required this.address,
    required this.photoUrl,
    required this.leaveBalances,
    required this.documentUrls,
  });

  /// Factory method to create an empty profile (fallback)
  factory ProfileData.empty() => ProfileData(
    name: 'Employee',
    designation: 'Officer',
    address: 'House',
    photoUrl: '',
    leaveBalances: {},
    documentUrls: [],
  );

  /// Factory to parse from JSON
  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      name: json['name'] ?? 'N/A',
      designation: json['designation'] ?? 'N/A',
      address: json['address'] ?? 'N/A',
      photoUrl: json['photoUrl'] ?? '',
      leaveBalances: Map<String, String>.from(json['leaveBalances'] ?? {}),
      documentUrls: List<String>.from(json['documentUrls'] ?? []),
    );
  }
}
