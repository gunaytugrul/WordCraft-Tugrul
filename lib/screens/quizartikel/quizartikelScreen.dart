import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:languagelearningapp/screens/quizartikel/result_screen.dart';
import 'package:firebase_database/firebase_database.dart';

class QuizArtikelScreen extends StatefulWidget {
  final String collectionName;

  const QuizArtikelScreen({Key? key, required this.collectionName}) : super(key: key);

  @override
  _QuizArtikelScreenState createState() => _QuizArtikelScreenState();
}

class _QuizArtikelScreenState extends State<QuizArtikelScreen> {
  final List<Map<String, String>> vocabularyList = [];
  String? selectedArticle;

  @override
  void initState() {
    super.initState();
    getDataFromFirestore();
  }

  void getDataFromFirestore() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(widget.collectionName)
        .get();

    setState(() {
      vocabularyList.clear();
      vocabularyList.addAll(querySnapshot.docs.map((doc) {
        return {
          'word': doc.get('word') as String,
          'article': doc.get('article') as String,
        };
      }));
    });

    pickRandomWord();
  }

  void pickRandomWord() {
    setState(() {
      selectedArticle = null;
    });
  }

  void checkAnswer(String article) {
    setState(() {
      selectedArticle = article;
    });

    Future.delayed(Duration(seconds: 1), () {
      if (vocabularyList.isNotEmpty) {
        String correctArticle = vocabularyList[0]['article'] ?? '';
        bool answeredCorrectly = (article == correctArticle);

        if (answeredCorrectly) {
          setState(() {
            selectedArticle = 'correct'; // You can set any identifier for the correct answer
          });
        } else {
          setState(() {
            selectedArticle = 'wrong'; // You can set any identifier for the wrong answer
          });
        }

        vocabularyList.removeAt(0);
        pickRandomWord();

        if (vocabularyList.isEmpty) {
          navigateToResultScreen();
        }
      }
    });
  }

  void navigateToResultScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          collectionName: widget.collectionName,
          onReset: () {
            Navigator.of(context).pop();
            getDataFromFirestore();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Question',
            style: TextStyle(
              color: Colors.purple,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              vocabularyList.isNotEmpty ? vocabularyList[0]['word'] ?? '' : '',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            children: ['das', 'die', 'der'].map((article) {
              return Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () => checkAnswer(article),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: selectedArticle == article
                        ? (article == vocabularyList[0]['article'] ? Colors.green : Colors.red)
                        : Colors.white,
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  ),
                  child: Text(article),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: pickRandomWord,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            ),
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}