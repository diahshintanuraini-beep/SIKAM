import 'package:flutter/material.dart';

class BalasPesanSiswaPage extends StatefulWidget {
  final List<Map<String, dynamic>> pesanSiswa;

  const BalasPesanSiswaPage({super.key, required this.pesanSiswa});

  @override
  State<BalasPesanSiswaPage> createState() => _BalasPesanSiswaPageState();
}

class _BalasPesanSiswaPageState extends State<BalasPesanSiswaPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        title: const Text("Balas Curhat Siswa"),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(26)),
              ),
              child: ListView.builder(
                itemCount: widget.pesanSiswa.length,
                itemBuilder: (_, i) {
                  final msg = widget.pesanSiswa[i];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(msg["data"]),
                        const SizedBox(height: 4),
                        Text(msg["time"],
                            style: const TextStyle(
                                fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Ketik balasan guru...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon:
                      const Icon(Icons.send, color: Colors.purple),
                  onPressed: () {
                    if (_controller.text.trim().isEmpty) return;
                    Navigator.pop(context, _controller.text.trim());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
