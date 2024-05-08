import 'package:flutter/material.dart';

class FlashCardViewWidget extends StatelessWidget {
  final String text;

  const FlashCardViewWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}

