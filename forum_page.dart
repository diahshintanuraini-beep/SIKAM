import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final List<Map<String, dynamic>> _messages = [
    {'sender': 'user1', 'message': 'Halo semua!', 'isMe': false, 'color': Colors.purple[400]},
    {'sender': 'user2', 'message': 'Hai juga!', 'isMe': true, 'color': Colors.grey[300]},
    {'sender': 'user3', 'message': 'Lagi pada bahas apa nih?', 'isMe': false, 'color': Colors.blue[400]},
    {'sender': 'user2', 'message': 'Lagi ngobrol santai aja kok', 'isMe': true, 'color': Colors.grey[300]},
    {'sender': 'user4', 'message': 'Ikutan dong!', 'isMe': false, 'color': Colors.yellow[700]},
    {'sender': 'user5', 'message': 'Boleh, boleh...', 'isMe': false, 'color': Colors.lightGreen[600]},
    {'sender': 'user6', 'message': 'Asik!', 'isMe': false, 'color': Colors.cyan[400]},
    {'sender': 'user7', 'message': 'Mantap!', 'isMe': false, 'color': Colors.redAccent},
  ];

  final TextEditingController _controller = TextEditingController();
  File? _imageFile;

  void _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty || _imageFile != null) {
      setState(() {
        _messages.add({
          'sender': 'user2',
          'message': _controller.text,
          'isMe': true,
          'color': Colors.grey[300],
          'imageFile': _imageFile,
        });
        _controller.clear();
        _imageFile = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF9C27B0),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(77),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Column(
              children: [
                Icon(Icons.groups, size: 40, color: Color(0xFF9C27B0)),
                SizedBox(height: 8),
                Text(
                  'forum komunitas',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessage(message['message']!, message['isMe']!,
                    message['color']!, message['imageFile']);
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessage(String message, bool isMe, Color color, File? imageFile) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe)
          CircleAvatar(
            backgroundColor: color,
            child: const Icon(Icons.person, color: Colors.white),
          ),
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: isMe ? Colors.grey[300] : color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageFile != null)
                Image.file(
                  imageFile,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              if (message.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    message,
                    style: TextStyle(color: isMe ? Colors.black : Colors.white),
                  ),
                ),
            ],
          ),
        ),
        if (isMe)
          const CircleAvatar(
            backgroundColor: Colors.black45,
            child: Icon(Icons.person, color: Colors.white),
          ),
      ],
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(77),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.attach_file, color: Color(0xFF9C27B0)),
            onPressed: _pickImage,
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Ketik sesuatu...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Color(0xFF9C27B0)),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
