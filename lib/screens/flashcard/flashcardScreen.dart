import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:languagelearningapp/screens/flashcard/ResultScreen.dart';
import 'package:languagelearningapp/screens/flashcard/flashcard_view.dart';

class FlashcardScreen extends StatefulWidget {
  final String collectionName;

  const FlashcardScreen({Key? key, required this.collectionName})
      : super(key: key);

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  List<FlashCard> _flashcards = [];
  int _currIndex = 0;

  @override
  void initState() {
    super.initState();
    _getFlashcardsFromFirebase();
  }

  Future<void> _getFlashcardsFromFirebase() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(widget.collectionName)
        .get();

    setState(() {
      _flashcards = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('question') && data.containsKey('answer')) {
          return FlashCard(
            question: data['question'],
            answer: data['answer'],
          );
        } else {
          return FlashCard(
            question: 'No question found',
            answer: 'No answer found',
          );
        }
      }).toList();
    });
  }

  void nextCard() {
    setState(() {
      if (_currIndex + 1 < _flashcards.length) {
        _currIndex++;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              totalQuestions: _flashcards.length,
              collectionName: widget.collectionName,
            ),
          ),
        );
      }
    });
  }

  void previousCard() {
    setState(() {
      _currIndex =
          (_currIndex - 1 >= 0) ? _currIndex - 1 : _flashcards.length - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FlashCard Quiz')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              height: 250,
              child: _flashcards.isEmpty
                  ? CircularProgressIndicator()
                  : GestureDetector(
                      onTap: () {
                        nextCard();
                      },
                      child: FlipCard(
                        front: FlashCardViewWidget(
                          text: _flashcards[_currIndex].question,
                        ),
                        back: FlashCardViewWidget(
                          text: _flashcards[_currIndex].answer,
                        ),
                      ),
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton.icon(
                  onPressed: previousCard,
                  icon: Icon(Icons.chevron_left),
                  label: Text('Prev'),
                ),
                OutlinedButton.icon(
                  onPressed: nextCard,
                  icon: Icon(Icons.chevron_right),
                  label: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class FlashCard {
  final String question;
  final String answer;

  FlashCard({required this.question, required this.answer});
}

