import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:languagelearningapp/screens/home_screen.dart';
import 'questions.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    Key? key,
    required this.score,
  }) : super(key: key);

  final int score;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('quiz_metadata').doc('metadata').get(), // Assuming metadata is stored in a document named 'metadata' in collection 'quiz_metadata'
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error fetching data'),
            ),
          );
        } else {
          final int totalQuestions = snapshot.data!.get('totalQuestions'); // Assuming 'totalQuestions' is a field in the document
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
              ),
              title: Text('Result'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 1000),
                const Text(
                  'Your Score: ',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 250,
                      width: 250,
                      child: CircularProgressIndicator(
                        strokeWidth: 10,
                        value: score / totalQuestions,
                        color: Colors.green,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          score.toString(),
                          style: const TextStyle(fontSize: 80),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${(score / totalQuestions * 100).round()}%',
                          style: const TextStyle(fontSize: 25),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
