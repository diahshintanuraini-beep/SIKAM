import 'package:flutter/material.dart';

class KuesionerPage extends StatefulWidget {
  const KuesionerPage({super.key});

  @override
  KuesionerPageState createState() => KuesionerPageState();
}

class KuesionerPageState extends State<KuesionerPage> {
  bool _isStarted = false;

  final int _totalQuestions = 17;
  late List<int?> _selectedAnswers;

  final List<String> _questions = [
    'Saya merasa nyaman berada di lingkungan sekolah',
    'Saya mampu berkonsentrasi dengan baik saat belajar',
    'Saya merasa percaya diri dengan kemampuan diri saya',
    'Saya memiliki hubungan yang baik dengan teman-teman',
    'Saya merasa dihargai oleh guru di sekolah',
    'Saya mampu mengelola emosi saya dengan baik',
    'Saya merasa stres dengan tugas sekolah',
    'Saya merasa memiliki motivasi untuk belajar',
    'Saya sering merasa cemas tanpa alasan yang jelas',
    'Saya mampu menyelesaikan masalah saya sendiri',
    'Saya merasa didukung oleh keluarga',
    'Saya merasa kesulitan mengatur waktu belajar',
    'Saya merasa puas dengan prestasi akademik saya',
    'Saya merasa mudah bergaul dengan orang lain',
    'Saya sering merasa tertekan dengan harapan orang lain',
    'Saya merasa memiliki tujuan yang jelas dalam hidup',
    'Saya membutuhkan bantuan konselor untuk masalah saya',
  ];

  @override
  void initState() {
    super.initState();
    _selectedAnswers = List<int?>.filled(_totalQuestions, null);
  }

  void _startQuiz() {
    setState(() {
      _isStarted = true;
    });
  }

  void _submitQuiz() {
    Map<int, int> results = {};
    for (var answer in _selectedAnswers) {
      if (answer != null) {
        results[answer] = (results[answer] ?? 0) + 1;
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hasil Kuesioner'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: results.entries.map((entry) {
                return Text(
                  'Opsi ${entry.key + 1}: ${entry.value} jawaban',
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _isStarted = false;
                  _selectedAnswers =
                      List<int?>.filled(_totalQuestions, null);
                });
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }

  // ================= START SCREEN =================
  Widget _buildStartScreen() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/kuesioner.png'),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black54, BlendMode.darken),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'KUISIONER KONSELING SISWA',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Silahkan isi kuisioner untuk melakukan Bimbingan Konseling',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF9C27B0).withAlpha(200),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: const BorderSide(color: Colors.white, width: 2),
                ),
                onPressed: _startQuiz,
                child: const Text(
                  'START',
                  style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= QUESTIONNAIRE SCREEN =================
  Widget _buildQuestionnaireScreen() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Keterangan Skala:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text('1 = Sangat Tidak Setuju'),
              Text('2 = Tidak Setuju'),
              Text('3 = Netral'),
              Text('4 = Setuju'),
              Text('5 = Sangat Setuju'),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _totalQuestions,
            itemBuilder: (context, index) {
              return _buildQuestionRow(index);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9C27B0),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: _submitQuiz,
            child: const Text(
              'SUBMIT',
              style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionRow(int index) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${index + 1}. ${_questions[index]}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (choiceIndex) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedAnswers[index] = choiceIndex;
                    });
                  },
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: _selectedAnswers[index] == choiceIndex
                          ? const Color(0xFF9C27B0)
                          : Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${choiceIndex + 1}',
                        style: TextStyle(
                          color:
                              _selectedAnswers[index] == choiceIndex
                                  ? Colors.white
                                  : Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'KUISIONER',
          style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF9C27B0),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isStarted ? _buildQuestionnaireScreen() : _buildStartScreen(),
    );
  }
}
