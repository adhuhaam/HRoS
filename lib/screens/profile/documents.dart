import 'package:flutter/material.dart';
import 'package:officeos/constants/api.dart';
import 'package:officeos/services/api_service.dart';
import 'package:officeos/models/document.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  List<EmployeeDocument> documents = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchDocuments();
  }

  Future<void> fetchDocuments() async {
    final response = await ApiService.get(ApiConstants.employeeDocuments);
    if (response != null && response['data'] != null) {
      setState(() {
        documents = List<EmployeeDocument>.from(
          response['data'].map((d) => EmployeeDocument.fromJson(d)),
        );
        loading = false;
      });
    }
  }

  Widget _buildImageCard(String? url, String label) {
    if (url == null || url.isEmpty) return const SizedBox.shrink();
    return Card(
      child: Column(
        children: [
          Image.network("https://hros.rccmaldives.com/assets/document/$url", height: 100, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Documents")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        padding: const EdgeInsets.all(10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: documents.expand((doc) {
          return [
            _buildImageCard(doc.photoFileName, "Photo"),
            _buildImageCard(doc.frontFileName, "Passport Front"),
            _buildImageCard(doc.backFileName, "Passport Back"),
            _buildImageCard(doc.pdfFileName, "Work Permit (PDF)"),
          ];
        }).toList(),
      ),
    );
  }
}
