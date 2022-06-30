import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:towermarket/models/order.dart';

class OrdersScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) {
      return const OrdersScreen();
    });
  }

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Orders"),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "New"),
              Tab(text: "In Progress"),
              Tab(text: "Completed"),
              Tab(text: "Cancel"),
            ],
          ),
        ),
        body: StreamBuilder<List<Order>>(
          stream: readAllInventry(),
          builder: (_, AsyncSnapshot<List<Order>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
              case ConnectionState.done:
                final List<Order> orders = snapshot.data!;
                return TabBarView(
                  children: [
                    NewOrders(orders: orders),
                    InProgressOrders(orders: orders),
                    CompletedOrders(orders: orders),
                    CancelOrders(orders: orders),
                  ],
                );
              default:
                return const Center(
                  child: Text("Somethign went wrong"),
                );
            }
          },
        ),
      ),
    );
  }

  Stream<List<Order>> readAllInventry() {
    return FirebaseFirestore.instance
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      return querySnapshot.docs.map(
          (QueryDocumentSnapshot<Map<String, dynamic>> queryDocumentSnapshot) {
        return Order.fromSnapshot(queryDocumentSnapshot);
      }).toList();
    });
  }
}

class NewOrders extends StatelessWidget {
  final List<Order> orders;
  const NewOrders({
    Key? key,
    required this.orders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (_, index) {
        return ListTile(
          leading: Text("${index + 1}"),
          title: Text(orders[index].reference!),
          subtitle: Text(orders[index].address),
          trailing: Text("PKR ${orders[index].total}"),
        );
      },
    );
  }
}

class InProgressOrders extends StatelessWidget {
  final List<Order> orders;
  const InProgressOrders({
    Key? key,
    required this.orders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (_, index) {
        return ListTile(
          leading: Text("${index + 1}"),
          title: Text(orders[index].reference!),
          subtitle: Text(orders[index].address),
          trailing: Text("PKR ${orders[index].total}"),
        );
      },
    );
  }
}

class CompletedOrders extends StatelessWidget {
  final List<Order> orders;
  const CompletedOrders({
    Key? key,
    required this.orders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (_, index) {
        return ListTile(
          leading: Text("${index + 1}"),
          title: Text(orders[index].reference!),
          subtitle: Text(orders[index].address),
          trailing: Text("PKR ${orders[index].total}"),
        );
      },
    );
  }
}

class CancelOrders extends StatelessWidget {
  final List<Order> orders;
  const CancelOrders({
    Key? key,
    required this.orders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (_, index) {
        return ListTile(
          leading: Text("${index + 1}"),
          title: Text(orders[index].reference!),
          subtitle: Text(orders[index].address),
          trailing: Text("PKR ${orders[index].total}"),
        );
      },
    );
  }
}
