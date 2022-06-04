import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_practice/services/auth.dart';
import 'package:firebase_practice/services/database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
    required this.email,
    required this.password,
    required this.msg,
  }) : super(key: key);
  final String email;
  final String password;
  final String msg;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();

  DatabaseService data = DatabaseService();

  @override
  void initState() {
    data.getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // data.getUserDetails();
    return SafeArea(
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            // 'Email: ${data.emails}'
              'Email: ${data.snapshot?['email']}'
              ),
          Text(
            // 'Password: ${data.passwords}'
              'Password: ${data.snapshot?['password']}'
              ),
          Text(widget.msg),
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
