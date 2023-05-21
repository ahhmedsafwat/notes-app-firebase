import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:notes/auth/signup.dart';

import '../components/alert.dart';
import '../home/home_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static String login = 'Login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? emailAddress, password;

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  logIn() async {
    if (formState.currentState!.validate()) {
      formState.currentState!.save();
      try {
        showLoading(context);
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailAddress!, password: password!);
        return credential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Navigator.pop(context);
          AwesomeDialog(
                  context: context,
                  title: 'There\'s no account for this email',
                  desc: 'if you do not have an account create one',
                  dialogType: DialogType.warning,
                  headerAnimationLoop: false)
              .show();
        } else if (e.code == 'wrong-password') {
          Navigator.pop(context);
          AwesomeDialog(
                  context: context,
                  title: 'Password or Email is wrong',
                  desc: 'The Password or the Email is wrong please try again',
                  dialogType: DialogType.error,
                  headerAnimationLoop: false)
              .show();
        }
      }
    }
  }

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
              key: formState,
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (newValue) {
                      emailAddress = newValue;
                    },
                    validator: (value) {
                      if (value!.length > 100) {
                        return 'email is too long';
                      }
                      if (value.length < 4) {
                        return 'email is too short';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1)),
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.alternate_email)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onChanged: (newValue) {
                      password = newValue;
                    },
                    validator: (value) {
                      if (value!.length > 100) {
                        return 'password is too long';
                      }
                      if (value.length < 6) {
                        return 'password is too short';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: 1)),
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
                          Navigator.pushReplacementNamed(
                              context, Signup.signup);
                        },
                      )
                    ]),
                  ),
                  Container(
                    child: ElevatedButton(
                      onPressed: () async {
                        var user = await logIn();
                        if (user != null && context.mounted) {
                          Navigator.pushReplacementNamed(
                              context, HomePage.homePage);
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
