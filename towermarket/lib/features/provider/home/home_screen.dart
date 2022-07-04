import 'package:flutter/material.dart';
import 'package:towermarket/colors/towermarket_colors.dart';
import 'package:towermarket/features/provider/account/account_screen.dart';
import 'package:towermarket/features/provider/dashboard/dashboard_screen.dart';
import 'package:towermarket/features/provider/home/components/my_bottom_navigation_bar.dart';
import 'package:towermarket/features/provider/inventry/create_inventry_screen.dart';
import 'package:towermarket/features/provider/inventry/inventry_screen.dart';
import 'package:towermarket/features/provider/notifications/notifications_screen.dart';
import 'package:towermarket/features/provider/orders/orders_screen.dart';

class HomeScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => const HomeScreen());
  }

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.cell_tower_rounded, size: 32),
        title: const Text("Towermarket"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, NotificationScreen.route());
            },
            icon: const Icon(Icons.notifications_rounded, size: 25),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context, AccountScreen.route());
            },
            icon: const Icon(Icons.person, size: 26),
          )
        ],
      ),
      body: _screens[selectedIndex],
      bottomNavigationBar: MyBottomNavigationBar(
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        selectedIndex: selectedIndex,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, CreateInventryScreen.route());
        },
        child: const Icon(Icons.add, color: TowermarketColors.white),
      ),
    );
  }

  final List<Widget> _screens = [
    const DashboardScreen(),
    const OrdersScreen(),
    const InventryScreen(),
  ];
}
