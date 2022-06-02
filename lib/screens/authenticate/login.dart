import 'package:firebase_practice/services/auth.dart';
import 'package:firebase_practice/screens/home/home.dart';
import 'package:firebase_practice/screens/authenticate/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.toggleAuthScreen}) : super(key: key);
  Function toggleAuthScreen;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();

  final formKey = GlobalKey<FormState>();

  var userGoogle = '';
  final emailCont = TextEditingController();
  final passCont = TextEditingController();
  String error = 'No errors, yet...';

  String email = '';
  String password = '';
  String msg = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailCont,
                decoration: const InputDecoration(hintText: 'Enter email'),
                validator: (email) {
                  if (email!.isEmpty) {
                    return 'Email field cannot be empty';
                  } else if (!email.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30.0),
              TextFormField(
                controller: passCont,
                decoration: const InputDecoration(hintText: 'Enter password'),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                obscuringCharacter: '*',
                validator: (password) {
                  if (password!.isEmpty) {
                    return 'Email field cannot be empty';
                  } else if (password.length < 6) {
                    return 'Enter a longer password';
                  } else if (!password.contains(RegExp(r"[0-9]"))) {
                    return 'Password must contain a number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    email = emailCont.text;
                    password = passCont.text;
                    msg = 'Signed in with email';
                  });
                  if (formKey.currentState!.validate()) {
                    dynamic result = await _auth.signInEmailAndPass(
                        emailCont.text, passCont.text);
                    if (result == null) {
                      setState(() => error = 'Error signing in');
                    }
                  }
                },
                child: const Text('Sign in'),
              ),
              const SizedBox(height: 20.0),
              InkWell(
                  onTap: () {
                    widget.toggleAuthScreen();
                  },
                  child: const Text(
                    'Or sign up',
                    style: TextStyle(color: Color.fromARGB(255, 89, 32, 165)),
                  )),
              const SizedBox(height: 20.0),
              Text(error),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  await _auth.signInWithGoogle();
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => HomePage(
                  //         email: userGoogle,
                  //         password: 'not used',
                  //         msg: 'Signed in with google'),
                  //   ),
                  // );
                  setState(() {
                    email = 'userGoogle';
                    password = 'not used';
                    msg = 'Signed in with google';
                  });
                },
                child: const Text("Sign in with google"),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  await _auth.signInWithPhoneNumber();
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => HomePage(
                  //
                  //   ),
                  // );
                  setState(() {
                    email = 'not used';
                    password = 'not used';
                    msg = 'Signed in with phone number';
                  });
                },
                child: const Text("Sign in with phone number"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
