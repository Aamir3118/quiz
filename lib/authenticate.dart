import 'package:flutter/material.dart';
import 'package:quiz/authform/sign_in.dart';
import 'package:quiz/authform/sign_up.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggle() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignUp(toggle: toggle);
    } else {
      return SignIn(toggle: toggle);
    }
  }
}
