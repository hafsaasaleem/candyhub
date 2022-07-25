import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:towermarket/auth/login_screen.dart';
import 'package:towermarket/products/view/product_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (_, AsyncSnapshot<User?> snaps) {
          switch (snaps.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            case ConnectionState.active:
            case ConnectionState.done:
              if (snaps.data != null) {
                return const ProductScreen();
              } else {
                return const LoginScreen();
              }
            default:
              return const LoginScreen();
          }
        },
      ),
    );
  }
}
