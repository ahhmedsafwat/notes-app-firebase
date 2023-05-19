import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/firebase_options.dart';

import 'auth/login.dart';
import 'auth/signup.dart';
import 'cred/add_notes.dart';
import 'home/home_page.dart';

bool isLogin = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final userstate = FirebaseAuth.instance.currentUser;
  if (userstate != null) {
    isLogin = true;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isLogin ? HomePage.homePage : Login.login,
      routes: {
        Login.login: (context) {
          return const Login();
        },
        Signup.signup: (context) {
          return const Signup();
        },
        HomePage.homePage: (context) {
          return const HomePage();
        },
        AddNotes.addNotes: (context) {
          return const AddNotes();
        }
      },
    );
  }
}
