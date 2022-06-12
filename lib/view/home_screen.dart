import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:towermarket/view/create_inventry_screen.dart';

import 'product_screen.dart';
import 'show_inventry_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Towermarket Provider"),
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
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Card(
                      child: TextButton(
                        child: const Text("Show Inventry"),
                        onPressed: () {
                          Navigator.push(context, ShowInventryScreen.route());
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: TextButton(
                        child: const Text("Create Inventry"),
                        onPressed: () {
                          Navigator.push(context, CreateInventryScreen.route());
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      child: TextButton(
                        child: const Text("Empty"),
                        onPressed: () {
                          Navigator.push(context, ShowInventryScreen.route());
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: TextButton(
                        child: const Text("Products"),
                        onPressed: () {
                          Navigator.push(context, ProductScreen.route());
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
