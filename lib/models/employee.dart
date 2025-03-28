class Employee {
  final String empNo;
  final String name;
  final String designation;
  final String department;
  final String email;
  final String phone;
  final String persentaddress;

  Employee({
    required this.empNo,
    required this.name,
    required this.designation,
    required this.department,
    required this.email,
    required this.phone,
    required this.persentaddress,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      empNo: json['emp_no'] ?? '',
      name: json['name'] ?? '',
      designation: json['designation'] ?? '',
      department: json['department'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      persentaddress: json['persentaddress'] ?? '',
    );
  }
}
// employee.dart - placeholder for models