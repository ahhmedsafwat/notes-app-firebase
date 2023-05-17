import 'package:flutter/material.dart';

import '../home/home_page.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  static String signup = 'Signup';

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
                decoration: const InputDecoration(
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 1)),
                    hintText: 'E-mail',
                    prefixIcon: Icon(Icons.alternate_email)),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                  hintText: 'username',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
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
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, HomePage.homePage);
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
