import 'package:flutter/material.dart';
import 'package:towermarket/colors/towermarket_colors.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final Function(int) onDestinationSelected;
  final int selectedIndex;

  const MyBottomNavigationBar(
      {Key? key,
      required this.onDestinationSelected,
      required this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Colors.white,
      elevation: 30,
      onDestinationSelected: onDestinationSelected,
      selectedIndex: selectedIndex,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.dashboard_rounded, size: 30),
          selectedIcon: Icon(
            Icons.dashboard_rounded,
            size: 30,
            color: TowermarketColors.brick,
          ),
          label: "Dashboard",
        ),
        NavigationDestination(
          icon: Icon(Icons.sell_rounded, size: 30),
          label: "Orders",
          selectedIcon: Icon(
            Icons.sell_rounded,
            size: 30,
            color: TowermarketColors.brick,
          ),
        ),
        NavigationDestination(
          icon: Icon(Icons.inventory, size: 30),
          label: "Inventry",
          selectedIcon: Icon(
            Icons.inventory,
            size: 30,
            color: TowermarketColors.brick,
          ),
        ),
      ],
    );
  }
}
