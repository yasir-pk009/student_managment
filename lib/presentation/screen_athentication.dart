import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_managment/presentation/pages/screen_home.dart';
import 'package:student_managment/presentation/pages/screen_loginOrregister.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const  ScreenHome();
          } else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}