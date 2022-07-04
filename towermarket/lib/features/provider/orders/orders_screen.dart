import 'package:flutter/material.dart';
import 'package:towermarket/colors/towermarket_colors.dart';

import 'components/cancel_orders.dart';
import 'components/completed_orders.dart';
import 'components/in_progress_orders.dart';
import 'components/new_orders.dart';

class OrdersScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) {
      return const OrdersScreen();
    });
  }

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          color: TowermarketColors.brick,
          child: TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs: const [
              Tab(text: "New"),
              Tab(text: "In Progress"),
              Tab(text: "Completed"),
              Tab(text: "Canceled"),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              NewOrders(),
              InProgressOrders(),
              CompletedOrders(),
              CancelOrders(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}
