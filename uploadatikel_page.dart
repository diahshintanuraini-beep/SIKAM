import 'package:flutter/material.dart';

class UploadArtikelPage extends StatefulWidget {
  const UploadArtikelPage({super.key});

  @override
  State<UploadArtikelPage> createState() => _UploadArtikelPageState();
}

class _UploadArtikelPageState extends State<UploadArtikelPage> {
  final TextEditingController judulController = TextEditingController();
  final TextEditingController isiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Artikel"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF9C27B0), Color(0xFFBA68C8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: judulController,
              decoration: InputDecoration(
                labelText: "Judul Artikel",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: isiController,
              maxLines: 6,
              decoration: InputDecoration(
                labelText: "Isi Artikel",
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9C27B0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Artikel berhasil diunggah"),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text(
                  "Upload Artikel",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
