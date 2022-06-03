import 'package:firebase_practice/models/user.dart';
import 'package:firebase_practice/screens/authenticate/authenticate.dart';
import 'package:firebase_practice/screens/authenticate/login.dart';
import 'package:firebase_practice/screens/authenticate/signup.dart';
import 'package:firebase_practice/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return HomePage(
      
      );
    }
  }
}
