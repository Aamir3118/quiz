import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz/quiz.dart';
import 'package:quiz/result.dart';
import 'package:quiz/services/auth.dart';

class MyHomePage extends StatefulWidget {
  final AuthService _auth = AuthService();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _questions = const [
    {
      'questionText': 'Who is called Mr.360 in Cricket?',
      'answers': [
        {'text': 'Sachin Tendulkar', 'score': 0},
        {'text': 'Virat Kohli', 'score': 0},
        {'text': 'Glenn Maxwell', 'score': 0},
        {'text': 'AB De Villiers', 'score': 1},
      ],
    },
    {
      'questionText': 'Who is Founder of C++ Language?',
      'answers': [
        {'text': 'Bjarne Stroustrup', 'score': 1},
        {'text': 'Guido van Rossum', 'score': 0},
        {'text': 'James Gosling', 'score': 0},
        {'text': 'None of these', 'score': 0},
      ],
    },
    {
      'questionText': 'Who was the first Prime Minister of india?',
      'answers': [
        {'text': 'Bhagat Singh', 'score': 0},
        {'text': 'Mahatma Gandhi', 'score': 0},
        {'text': 'Jawaharlal Nehru', 'score': 1},
        {'text': 'None of these', 'score': 0},
      ],
    },
    {
      'questionText': 'Which planet is nearest to earth',
      'answers': [
        {'text': 'Mercury', 'score': 1},
        {'text': 'Jupiter', 'score': 0},
        {'text': 'Mars', 'score': 0},
        {'text': 'All of these', 'score': 0},
      ],
    },
    {
      'questionText': 'Which is the national animal of India?',
      'answers': [
        {'text': 'Zebra', 'score': 0},
        {'text': 'Elephant', 'score': 0},
        {'text': 'Lion', 'score': 0},
        {'text': 'Tiger', 'score': 1},
      ],
    },
  ];
  /* @override
  void initState() {
    FirebaseFirestore.instance
        .collection('questions')
        .add({'ques': _questions.toList()});
    super.initState();
  }*/

  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    // var aBool = true;
    // aBool = false;

    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton.icon(
              onPressed: () async {
                await widget._auth.signOut();
              },
              icon: Icon(Icons.exit_to_app),
              label: Text('Logout'))
        ],
        title: Text('Quiz App'),
      ),
      body: _questionIndex < _questions.length
          ? Quiz(
              answerQuestion: _answerQuestion,
              questionIndex: _questionIndex,
              questions: _questions,
            )
          : Result(_totalScore, _resetQuiz),
    );
  }
}


/*class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        FlatButton.icon(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: Icon(Icons.exit_to_app),
            label: Text('Logout'))
      ]),
    );
  }
}*/
