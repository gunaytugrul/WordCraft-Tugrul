import 'package:flutter/material.dart';
import 'package:languagelearningapp/screens/flashcard/flashcardScreen.dart';
import 'package:languagelearningapp/screens/games.dart';
import 'package:languagelearningapp/screens/home_screen.dart';

class ResultScreen extends StatelessWidget {
  final int totalQuestions;
  final String collectionName;

  const ResultScreen({
    Key? key,
    required this.totalQuestions,
    required this.collectionName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Result')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Questions: $totalQuestions',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FlashcardScreen(collectionName: collectionName)),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.games),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GamesPage(categoryName: collectionName,)),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


