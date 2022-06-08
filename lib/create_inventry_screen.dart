import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateInventryScreen extends StatelessWidget {
  const CreateInventryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: const Icon(Icons.logout)),
          )
        ],
        title: const Text("Towermarket"),
      ),
      body: const Center(
        child: Text("Inventry Screen"),
      ),
    );
  }
}
