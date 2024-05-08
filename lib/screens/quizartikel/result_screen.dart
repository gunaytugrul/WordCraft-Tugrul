import 'package:flutter/material.dart';
import 'package:languagelearningapp/screens/games.dart';
import 'package:languagelearningapp/screens/home_screen.dart';
import 'package:languagelearningapp/screens/quizartikel/quizartikelScreen.dart';

class ResultScreen extends StatelessWidget {
  final VoidCallback onReset;
  final String collectionName;

  const ResultScreen({
    Key? key,
    required this.onReset,
    required this.collectionName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuizArtikelScreen(collectionName: collectionName)),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.games),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GamesPage(categoryName: collectionName)),
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