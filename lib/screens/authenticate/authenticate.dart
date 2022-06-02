import 'package:firebase_practice/screens/authenticate/login.dart';
import 'package:firebase_practice/screens/authenticate/signup.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleAuthScreen() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LoginPage(toggleAuthScreen: toggleAuthScreen);
    } else {
      return SignupPage(toggleAuthScreen: toggleAuthScreen);
    }
  }
}
