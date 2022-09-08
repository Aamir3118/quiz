import 'package:flutter/material.dart';
import 'package:quiz/services/auth.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp({required this.toggle});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _usernameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();
  bool loading = false;

  String username = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String error = '';
/*
  @override
  void dispose() {
    if (_formKey.currentState!.validate()) _usernameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return loading
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
            color: Colors.white,
          )
        : Scaffold(
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade800, Colors.green],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'SignUp',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              focusNode: _usernameFocus,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_emailFocus);
                              },
                              decoration: InputDecoration(
                                hintText: 'Username',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Enter Username';
                                } else if (val.length <= 3) {
                                  return 'Username should be greater than 3 characters long';
                                } else {
                                  null;
                                }
                              },
                              onChanged: (val) {
                                setState(() {
                                  username = val.trim();
                                });
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocus);
                              },
                              focusNode: _emailFocus,
                              decoration: InputDecoration(
                                hintText: 'Email Address',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Enter Email Address';
                                } else {
                                  null;
                                }
                              },
                              onChanged: (val) {
                                setState(() {
                                  email = val.trim();
                                });
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_confirmPasswordFocus);
                              },
                              focusNode: _passwordFocus,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              obscureText: true,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Enter Password';
                                } else if (val.length <= 6) {
                                  return 'Password length should be greater than 6';
                                } else {
                                  null;
                                }
                              },
                              onChanged: (val) {
                                setState(() {
                                  password = val;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              focusNode: _confirmPasswordFocus,
                              decoration: InputDecoration(
                                hintText: 'Confirm Password',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              obscureText: true,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Enter Confirm Password';
                                } else if (val != password) {
                                  return 'Confirm Password should match';
                                } else {
                                  null;
                                }
                              },
                              onChanged: (val) {
                                setState(() {
                                  confirmPassword = val;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25))),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blue.shade800)),
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save;
                                      setState(() {
                                        loading = true;
                                      });
                                      dynamic result =
                                          await _auth.signUpWithEmailPassword(
                                              username, email, password);
                                      if (result == null) {
                                        setState(() {
                                          error = 'Please enter a valid email';
                                          setState(() {
                                            loading = false;
                                          });
                                        });
                                      }
                                      print(email);
                                      print(password);
                                    }
                                  },
                                  child: Text(
                                    'SignUp',
                                    //style: TextStyle(fontSize: 16),
                                    textScaleFactor: 1.6,
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Already have an account?',
                                  style: TextStyle(fontSize: 18),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    widget.toggle();
                                  },
                                  child: Text(
                                    'SignIn',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              error,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                              ),
                            )
                            /* ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue.shade800)),
                      onPressed: () async {
                        dynamic result = await _auth.signInAnon();
                        if (result == null) {
                          print('error signing in');
                        } else {
                          print('signed in');
                          print(result.uid);
                        }
                      },
                      child: Text(
                        'Sign in anon',
                        //style: TextStyle(fontSize: 16),
                        textScaleFactor: 1.6,
                      )),*/
                          ],
                        ),
                      )),
                ),
              ),
            ),
          );
  }
}
