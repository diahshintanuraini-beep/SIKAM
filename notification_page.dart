import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'kuesioner_page.dart';
import 'artikel_page.dart';
import 'profile_page.dart';
import 'chat_page.dart'; // pastikan file ini ada

// ================= MODEL =================
class _Notification {
  final String name;
  final String nip;
  final String status;
  final bool isUnread;
  final bool hasChat;

  _Notification({
    required this.name,
    required this.nip,
    required this.status,
    required this.isUnread,
    required this.hasChat,
  });
}

// ================= PAGE =================
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int _selectedIndex = 0;

  final List<_Notification> _allNotifications = [
    _Notification(
      name: 'Ria Yurliza Sapitri, S.Pd.',
      nip: 'NIP. 123456789101234567',
      status: 'Percakapan berlangsung',
      isUnread: true,
      hasChat: true,
    ),
    _Notification(
      name: 'Diah Sinta Nuraeini, S.Pd.',
      nip: 'NIP. 123456789101234567',
      status: 'Percakapan telah selesai',
      isUnread: false,
      hasChat: false,
    ),
    _Notification(
      name: 'Budi Santoso, S.Kom.',
      nip: 'NIP. 987654321098765432',
      status: 'Menunggu balasan Anda',
      isUnread: true,
      hasChat: true,
    ),
    _Notification(
      name: 'Citra Lestari, M.Psi.',
      nip: 'NIP. 543210987654321098',
      status: 'Percakapan telah selesai',
      isUnread: false,
      hasChat: false,
    ),
  ];

  late List<_Notification> _filteredNotifications;

  @override
  void initState() {
    super.initState();
    _filteredNotifications = List.from(_allNotifications);
  }

  void _filterNotifications(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        _filteredNotifications =
            _allNotifications.where((n) => !n.isUnread).toList();
      } else if (index == 2) {
        _filteredNotifications =
            _allNotifications.where((n) => n.isUnread).toList();
      } else {
        _filteredNotifications = List.from(_allNotifications);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryPurple = Color.fromARGB(255, 163, 17, 203);
    const Color secondaryPurple = Color.fromARGB(255, 195, 31, 250);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Kotak Masuk',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryPurple, secondaryPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildFilterTabs(primaryPurple),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredNotifications.length,
              itemBuilder: (context, index) {
                final n = _filteredNotifications[index];
                return _buildNotificationItem(
                  primaryPurple: primaryPurple,
                  name: n.name,
                  nip: n.nip,
                  status: n.status,
                  isUnread: n.isUnread,
                  hasChat: n.hasChat,
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          _buildBottomNavBar(primaryPurple, secondaryPurple),
    );
  }

  // ================= UI COMPONENTS =================
  Widget _buildFilterTabs(Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _filterButton('Semua', 0, color),
          _filterButton('Sudah dibaca', 1, color),
          _filterButton('Belum dibaca', 2, color),
        ],
      ),
    );
  }

  Widget _filterButton(String text, int index, Color color) {
    final bool selected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _filterNotifications(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? color : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required Color primaryPurple,
    required String name,
    required String nip,
    required String status,
    required bool isUnread,
    required bool hasChat,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.account_circle,
                    size: 50, color: primaryPurple),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(nip,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 14)),
                    ],
                  ),
                ),
                if (isUnread)
                  Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: primaryPurple,
                      shape: BoxShape.circle,
                    ),
                    child: const Text('!',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  status,
                  style: TextStyle(
                      color: primaryPurple,
                      fontWeight: FontWeight.bold),
                ),
                if (hasChat)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatPage(
                            name: name,
                            nip: nip,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          primaryPurple.withAlpha(38),
                      foregroundColor: primaryPurple,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Buka Chat'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(Color p, Color s) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [p.withAlpha(230), s.withAlpha(230)],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: 1,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const DashboardPage()));
              break;
            case 1:
              break;
            case 2:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const KuesionerPage()));
              break;
            case 3:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const ArtikelPage()));
              break;
            case 4:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()));
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }
}
