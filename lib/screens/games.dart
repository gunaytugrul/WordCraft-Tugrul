import 'package:flutter/material.dart';
import 'flashcard/flashcardScreen.dart';
import 'quizartikel/quizartikelScreen.dart';
import 'quiz/quiz_screen.dart';

class GamesPage extends StatelessWidget {
  final String categoryName; // Kategori adını tutacak değişken

  // Constructor'a categoryName eklendi
  const GamesPage({Key? key, required this.categoryName}) : super(key: key);

  // Function to create a square elevated button with consistent styling
  Widget buildElevatedButton({
    required String text,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName), // Kategori adını başlık olarak gösteriyoruz
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildElevatedButton(
                text: 'Flashcards',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FlashcardScreen(collectionName: categoryName)),
                  );
                },
                color: Colors.blue,
              ),
              SizedBox(height: 20),
              buildElevatedButton(
                text: 'Quiz Artikel',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizArtikelScreen(collectionName: categoryName)),
                  );
                },
                color: Colors.green,
              ),
              SizedBox(height: 20),
              buildElevatedButton(
                text: 'Quiz',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizScreen(collectionName: categoryName)),
                  );   
                },
                color: Colors.orange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}