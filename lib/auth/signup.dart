import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  static String signup = 'Signup';

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String? password, email, username;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  SignUp() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email!,
          password: password!,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          AwesomeDialog(
            context: context,
            title: 'weak password',
            body: const Text('the password you provided is too weak'),
          );
        } else if (e.code == 'email-already-in-use') {
          AwesomeDialog(
              context: context,
              title: 'email already exists',
              body: const Text(
                  'the email you are trying to sign up with already exists '));
        }
      } catch (e) {
        print(e);
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('not vaild')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const SizedBox(
          height: 100,
        ),
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
                    validator: (value) {
                      if (value!.length > 100) {
                        return 'email is too long';
                      }
                      if (value.length < 4) {
                        return 'email is too short';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      email = newValue;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1)),
                        hintText: 'E-mail',
                        prefixIcon: Icon(Icons.alternate_email)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onSaved: (newValue) {
                      username = newValue;
                    },
                    validator: (value) {
                      if (value!.length > 100) {
                        return 'username is too long';
                      }
                      if (value.length < 4) {
                        return 'username is too short';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: 1)),
                      hintText: 'username',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.length > 100) {
                        return 'password is too long';
                      }
                      if (value.length < 6) {
                        return 'password is too short';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      password = newValue;
                    },
                    decoration: const InputDecoration(
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: 1)),
                      hintText: 'password',
                      prefixIcon: Icon(Icons.visibility_off),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(children: [
                      const Text('Already have an account ? '),
                      InkWell(
                        child: const Text(
                          'Click here',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onTap: () {
                          Navigator.pushReplacementNamed(context, Login.login);
                        },
                      )
                    ]),
                  ),
                  Container(
                    child: ElevatedButton(
                      onPressed: () async {
                        await SignUp();
                      },
                      child: const Text(
                        'Sign Up',
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
