import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'models/shopping_cart.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter((ShoppingCartAdapter()));
  await Hive.openBox<ShoppingCart>('shoppingcart');


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}
