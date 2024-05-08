class Question {
  final String imagePath; // New field for the image path
  final List<String> options;
  final int correctAnswerIndex;

  const Question({
    required this.correctAnswerIndex,
    required this.imagePath,
    required this.options,
  });
}