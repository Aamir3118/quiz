import 'package:flutter/material.dart';
import 'package:quiz/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn({required this.toggle});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  final _passwordFocus = FocusNode();
  final _emailFocus = FocusNode();
  String email = '';
  String password = '';
  String error = '';

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
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
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
                                'SignIn',
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
                                focusNode: _emailFocus,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_passwordFocus);
                                },
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
                                        setState(() {
                                          loading = true;
                                        });
                                        dynamic result =
                                            await _auth.signInWithEmailPassword(
                                                email, password);
                                        if (result == null) {
                                          setState(() {
                                            error = 'Could not sign in';
                                            setState(() {
                                              loading = false;
                                            });
                                          });
                                        }
                                      }
                                    },
                                    child: Text(
                                      'SignIn',
                                      //style: TextStyle(fontSize: 16),
                                      textScaleFactor: 1.6,
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Don\'t have an account?',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      widget.toggle();
                                    },
                                    child: Text(
                                      'SignUp',
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
            ),
          );
  }
}
