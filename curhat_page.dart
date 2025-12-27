import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'balaspesansiswa_page.dart';

class CurhatPage extends StatefulWidget {
  const CurhatPage({super.key});

  @override
  State<CurhatPage> createState() => _CurhatPageState();
}

class _CurhatPageState extends State<CurhatPage> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();

  String _timeNow() {
    final now = DateTime.now();
    return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
  }

  void _scrollBottom() {
    Future.delayed(const Duration(milliseconds: 120), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendText() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _messages.add({
        "type": "text",
        "data": _controller.text.trim(),
        "me": true,
        "time": _timeNow(),
      });
    });
    _controller.clear();
    _scrollBottom();
  }

  Future<void> _sendImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    setState(() {
      _messages.add({
        "type": "image",
        "data": image.path,
        "me": true,
        "time": _timeNow(),
      });
    });
    _scrollBottom();
  }

  Future<void> _kirimKeGuru() async {
    final balasan = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BalasPesanSiswaPage(
          pesanSiswa: List.from(_messages),
        ),
      ),
    );

    if (balasan != null) {
      setState(() {
        _messages.add({
          "type": "text",
          "data": balasan,
          "me": false,
          "time": _timeNow(),
        });
      });
      _scrollBottom();
    }
  }

  Widget _buildBubble(Map<String, dynamic> msg) {
    final bool me = msg["me"];
    final bool isImage = msg["type"] == "image";

    return Align(
      alignment: me ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding:
                isImage ? const EdgeInsets.all(6) : const EdgeInsets.all(10),
            constraints: const BoxConstraints(maxWidth: 220),
            decoration: BoxDecoration(
              color: isImage
                  ? Colors.transparent
                  : (me ? Colors.purple[200] : Colors.grey[300]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: isImage
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: kIsWeb
                        ? Image.network(msg["data"], width: 160, height: 160)
                        : Image.file(File(msg["data"]),
                            width: 160, height: 160),
                  )
                : Text(msg["data"]),
          ),
          Text(
            msg["time"],
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  IconButton(
                    icon:
                        const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Text(
                      "CURHAT ANONYMOUS",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.forward_to_inbox,
                        color: Colors.white),
                    onPressed: _kirimKeGuru,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(26)),
                ),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _messages.length,
                  itemBuilder: (_, i) => _buildBubble(_messages[i]),
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(
                    icon:
                        const Icon(Icons.image, color: Colors.purple),
                    onPressed: _sendImage,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: "Ketik curhat kamu...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon:
                        const Icon(Icons.send, color: Colors.purple),
                    onPressed: _sendText,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
