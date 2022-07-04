import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NotificationScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => const NotificationScreen());
  }

  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notfication"),
      ),
      body: Center(
        child: Text("Notfication"),
      ),
    );
  }
}
