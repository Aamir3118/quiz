import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/authenticate.dart';
import 'package:quiz/authform/sign_up.dart';
import 'package:quiz/my_home_page.dart';
import 'package:quiz/user_model.dart';

class Wrapper extends StatefulWidget {
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return MyHomePage();
    }
  }
}
