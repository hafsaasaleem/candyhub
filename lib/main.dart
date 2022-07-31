import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'firebase_options.dart';
import 'models/shopping_cart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/screens.dart';
import 'utilities/towermarket_theme.dart';

Future<void> main() async {
  await Hive.initFlutter();

  Hive.registerAdapter((ShoppingCartAdapter()));
  await Hive.openBox<ShoppingCart>('shoppingcart');

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: TowermarketTheme.standard,
      home: const ProductScreen(),
    );
  }
}
