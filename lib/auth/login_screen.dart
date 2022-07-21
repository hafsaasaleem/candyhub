import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => const LoginScreen());
  }

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SIGN IN")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            TextField(
              controller: _email,
              decoration: const InputDecoration(hintText: "email"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _password,
              decoration: const InputDecoration(hintText: "password"),
            ),
            ElevatedButton(
              onPressed: () {
                _login();
              },
              child: const Text("SIGN IN"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text, password: _password.text);
    } catch (e) {
      log("Error: $e");
    }
  }
}
