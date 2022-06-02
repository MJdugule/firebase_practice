import 'package:firebase_practice/screens/home/home.dart';
import 'package:firebase_practice/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_practice/screens/authenticate/login.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key, required this.toggleAuthScreen}) : super(key: key);
  Function toggleAuthScreen;

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final AuthService _auth = AuthService();
  final formKey = GlobalKey<FormState>();

  final emailCont = TextEditingController();
  final passCont = TextEditingController();
  final passConfirmCont = TextEditingController();
  String msg = 'No message';
  String error = 'No errors, yet...';

  // String email = '';
  // String password = '';

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
              TextFormField(
                controller: passConfirmCont,
                decoration: const InputDecoration(hintText: 'Confirm password'),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                obscuringCharacter: '*',
                validator: (passwordConfirm) {
                  if (passwordConfirm != passCont.text) {
                    return 'Passwords don\'t match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    dynamic result = await _auth.registerEmailAndPass(
                        emailCont.text, passCont.text);
                    // setState(
                    // () {
                    // msg = 'Validation was successful';

                    // dynamic result = await _auth.signUpWithEmailAndPassword(
                    //     email, password);

                    if (result == null) {
                      error = 'Error signing up';
                    }
                    // else {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => HomePage(
                    //       email: emailCont.text,
                    //       msg: msg,
                    //       password: passCont.text,
                    //       error: error,
                    //     ),
                    //   ),
                    // );
                    // }
                    // },
                    // );
                  }
                },
                child: const Text('Submit'),
              ),
              const SizedBox(height: 20.0),
              InkWell(
                onTap: () {
                  widget.toggleAuthScreen();

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const LoginPage(),
                  // ),
                  // );
                },
                child: const Text(
                  'Or sign in',
                  style: TextStyle(color: Color.fromARGB(255, 89, 32, 165)),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(error),
            ],
          ),
        ),
      ),
    );
  }
}
