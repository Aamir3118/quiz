import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiz/my_home_page.dart';
import 'package:quiz/services/auth.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final VoidCallback resetHandler;

  Result(this.resultScore, this.resetHandler);

  String get resultPhrase {
    String resultText;
    if (resultScore == 4 || resultScore == 5) {
      resultText = 'Congratulations!';
    } else {
      resultText = 'Better Luck next time!';
    }
    return resultText;
  }

  void _submit() async {
    final user = await FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    FirebaseFirestore.instance.collection('result').add({
      'score': resultScore.toString(),
      'email': userData.data()!['email'],
      'username': userData.data()!['username'],
      'userId': user.uid,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  resultPhrase,
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'You Scored ' + resultScore.toString(),
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            RaisedButton(
                color: Colors.blue,
                child: Text(
                  'Submit Quiz!',
                ),
                textColor: Colors.black,
                onPressed: () {
                  _submit();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => MyHomePage()));
                }),
            RaisedButton(
              color: Colors.blue,
              child: Text(
                'Restart Quiz!',
              ),
              textColor: Colors.black,
              onPressed: resetHandler,
            ),
          ],
        ),
      ),
    );
  }
}
