import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:towermarket/features/auth/login_screen.dart';
import 'package:towermarket/features/provider/home/home_screen.dart';
import 'package:towermarket/features/select_user_type_screen.dart';

import 'towermarket_theme.dart';
import 'features/splash_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: TowermarketTheme.standard,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (_, AsyncSnapshot<User?> snaps) {
          switch (snaps.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const SplashScreen();
            case ConnectionState.active:
            case ConnectionState.done:
              if (snaps.data != null) {
                return const HomeScreen();
              } else {
                return const SelectUserTypeScreen();
              }
            default:
              return const LoginScreen();
          }
        },
      ),
    );
  }
}
