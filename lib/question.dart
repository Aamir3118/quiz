import 'package:flutter/material.dart';

class Question extends StatefulWidget {
  final int questionIndex;

  final String questionText;

  Question(this.questionIndex, this.questionText);

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  var quesIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(
        ('Q${widget.questionIndex + 1} ${widget.questionText}'),
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}
