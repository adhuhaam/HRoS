class EmployeeDocument {
  final String docType;
  final String? photoFileName;
  final String? frontFileName;
  final String? backFileName;
  final String? pdfFileName;

  EmployeeDocument({
    required this.docType,
    this.photoFileName,
    this.frontFileName,
    this.backFileName,
    this.pdfFileName,
  });

  factory EmployeeDocument.fromJson(Map<String, dynamic> json) {
    return EmployeeDocument(
      docType: json['doc_type'] ?? '',
      photoFileName: json['photo_file_name'],
      frontFileName: json['front_file_name'],
      backFileName: json['back_file_name'],
      pdfFileName: json['pdf_file_name'],
    );
  }
}
