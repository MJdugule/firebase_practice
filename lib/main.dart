import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_practice/models/user.dart';
import 'package:firebase_practice/screens/authenticate/login.dart';
import 'package:firebase_practice/screens/wrapper.dart';
import 'package:firebase_practice/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      initialData: null,
      value: AuthService().user,
      child: const MaterialApp(
        title: 'Firebase Practice',
        home: Wrapper(),
      ),
    );
  }
}
