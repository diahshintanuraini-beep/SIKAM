import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dashboard_page.dart';
import 'kuesioner_page.dart';
import 'notification_page.dart';
import 'profile_page.dart';

class ArtikelPage extends StatelessWidget {
  const ArtikelPage({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await canLaunchUrl(uri)) {
      throw 'Tidak bisa membuka $url';
    }
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryPurple = Color.fromARGB(255, 163, 17, 203);
    const Color secondaryPurple = Color.fromARGB(255, 195, 31, 250);

    final List<Map<String, String>> articles = [
      {
        "title": "Mengenal Minat & Bakat",
        "image": "assets/images/artikel1.png",
        "desc":
            "Memahami minat dan bakat adalah langkah awal menentukan masa depan karir.",
        "link":
            "https://ormawa.stekom.ac.id/berita/cara-mengembangkan-minat-dan-bakat"
      },
      {
        "title": "Jurusan Populer di UN",
        "image": "assets/images/artikel2.png",
        "desc":
            "Beberapa jurusan favorit di universitas negeri memiliki prospek kerja yang baik.",
        "link":
            "https://sevima.com/21-jurusan-kuliah-paling-diminati-dan-populer-di-indonesia/"
      },
      {
        "title": "Tips Belajar Efektif",
        "image": "assets/images/artikel3.png",
        "desc":
            "Teknik belajar yang tepat dapat meningkatkan fokus dan pemahaman materi.",
        "link":
            "https://cintakasihtzuchi.sch.id/mengenal-gaya-belajar-untuk-meningkatkan-efektivitas-pembelajaran/"
      },
      {
        "title": "Pentingnya Kesehatan Mental",
        "image": "assets/images/artikel4.png",
        "desc":
            "Kesehatan mental sama pentingnya dengan kesehatan fisik, terutama bagi pelajar.",
        "link": "https://ayosehat.kemkes.go.id/cara-menjaga-kesehatan-mental"
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'ARTIKEL',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryPurple, secondaryPurple],
            ),
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];

          return GestureDetector(
            onTap: () => _launchUrl(article["link"]!),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: Image.asset(
                      article["image"]!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article["title"]!,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryPurple,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            article["desc"]!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Spacer(),
                          const Text(
                            "Lihat selengkapnya",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryPurple,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar:
          _buildBottomNavBar(context, primaryPurple, secondaryPurple),
    );
  }

  Widget _buildBottomNavBar(
    BuildContext context,
    Color primaryPurple,
    Color secondaryPurple,
  ) {
    return BottomNavigationBar(
      currentIndex: 3,
      selectedItemColor: primaryPurple,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const DashboardPage()));
            break;
          case 1:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const NotificationPage()));
            break;
          case 2:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const KuesionerPage()));
            break;
          case 3:
            // Already on this page
            break;
          case 4:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const ProfilePage()));
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications), label: 'Notifikasi'),
        BottomNavigationBarItem(
            icon: Icon(Icons.assignment), label: 'Kuesioner'),
        BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Artikel'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
      ],
    );
  }
}
