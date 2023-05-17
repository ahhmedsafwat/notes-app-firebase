import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/auth/signup.dart';

import '../home/home_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static String login = 'Login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? emailAddress;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            'assets/images/owl.png',
            color: Colors.blue,
            width: 120,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              child: Column(
            children: [
              TextFormField(
                onChanged: (newValue) {
                  emailAddress = newValue;
                },
                decoration: const InputDecoration(
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 1)),
                    hintText: 'username',
                    prefixIcon: Icon(Icons.person)),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (newValue) {
                  password = newValue;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                  hintText: 'password',
                  prefixIcon: Icon(Icons.visibility_off),
                ),
                obscureText: true,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(children: [
                  Text('if you don\'t have an account '),
                  InkWell(
                    child: const Text(
                      'Click here',
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, Signup.signup);
                    },
                  )
                ]),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: emailAddress!, password: password!);
                      Navigator.pushReplacementNamed(
                          context, HomePage.homePage);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              )
            ],
          )),
        )
      ],
    ));
  }
}
