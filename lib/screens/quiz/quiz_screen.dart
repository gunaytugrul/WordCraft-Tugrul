import 'package:flutter/material.dart';
import 'package:languagelearningapp/screens/quiz/answer_card.dart';
import 'package:languagelearningapp/screens/quiz/next_button.dart';
import 'package:languagelearningapp/screens/quiz/questions.dart';
import 'package:languagelearningapp/screens/quiz/result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String collectionName;
  const QuizScreen({Key? key, required this.collectionName}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? selectedAnswerIndex;
  int questionIndex = 0;
  int score = 0;

  void pickAnswer(int value) {
    selectedAnswerIndex = value;
    final question = questions[questionIndex];
    if (selectedAnswerIndex == question.correctAnswerIndex) {
      score++;
    }
    setState(() {});
  }

  void goToNextQuestion() {
    if (questionIndex < questions.length - 1) {
      questionIndex++;
      selectedAnswerIndex = null;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[questionIndex];
    bool isLastQuestion = questionIndex == questions.length - 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          SizedBox(
            width: 120,
            height: 180,
            child: Image.asset(
              question.imagePath, // Assuming imagePath is a valid asset path
              fit: BoxFit.contain, // Ensures image covers the container
            ),
          ),
          SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: question.options.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: selectedAnswerIndex == null ? () => pickAnswer(index) : null,
                child: AnswerCard(
                  currentIndex: index,
                  question: question.options[index],
                  isSelected: selectedAnswerIndex == index,
                  selectedAnswerIndex: selectedAnswerIndex,
                  correctAnswerIndex: question.correctAnswerIndex,
                ),
              );
            },
          ),
          SizedBox(height: 20),
          isLastQuestion
              ? RectangularButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ResultScreen(
                          score: score,
                        ),
                      ),
                    );
                  },
                  label: 'Finish',
                )
              : RectangularButton(
                  onPressed: selectedAnswerIndex != null ? goToNextQuestion : null,
                  label: 'Next',
                ),
        ],
      ),
    );
  }
}
