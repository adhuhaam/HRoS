import 'package:flutter/material.dart';

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final documents = [
      {
        'type': 'Passport (Front)',
        'file': 'https://hros.rccmaldives.com/assets/document/passport_front.png',
        'isPdf': false
      },
      {
        'type': 'Passport (Back)',
        'file': 'https://hros.rccmaldives.com/assets/document/passport_back.png',
        'isPdf': false
      },
      {
        'type': 'Work Permit Card',
        'file': 'https://hros.rccmaldives.com/assets/document/work_card.png',
        'isPdf': false
      },
      {
        'type': 'Work Permit PDF',
        'file': 'https://hros.rccmaldives.com/assets/document/work_permit.pdf',
        'isPdf': true
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Documents",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: documents.length,
        itemBuilder: (context, index) {
          final doc = documents[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [BoxShadow(blurRadius: 6, color: Colors.black12)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doc['type'] as String,

                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 10),
                if (doc['isPdf'] == true) Container(
                  height: 50,
                  color: Colors.grey.shade200,
                  child: Row(
                    children: [
                      const Icon(Icons.picture_as_pdf, color: Colors.red),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(doc['file'] as String,

                            overflow: TextOverflow.ellipsis),
                      ),
                      IconButton(
                          onPressed: () {
                            // TODO: open PDF preview
                          },
                          icon: const Icon(Icons.open_in_new))
                    ],
                  ),
                ) else ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Text(doc['type']?.toString() ?? ''),



          ),
              ],
            ),
          );
        },
      ),
    );
  }
}
