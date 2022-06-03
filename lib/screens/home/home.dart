import 'package:firebase_practice/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatelessWidget {
  HomePage({
    Key? key,
    // required this.email,
    // required this.password,
    // required this.msg,
  }) : super(key: key);
  // final String email;
  // final String password;
  // final String msg;

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text('Email: $email'),
          // Text('Password: $password'),
          // Text(msg),
          const SizedBox(height: 50.0),
          InkWell(
            onTap: (() async {
              await _auth.signOut();

              // Navigator.pop(context);
            }),
            child: const Text('Back'),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () async {
              await _auth.signOut();
              await GoogleSignIn().signOut();
            },
            child: Text("Sign out"),
          )
        ],
      )),
    );
  }
}
