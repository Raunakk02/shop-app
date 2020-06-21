import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_practice/widgets/order_item.dart';
import '../providers/order.dart' show Order;
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Order>(context).items;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx,index){
          return OrderItem(orders[index]);
        },
        itemCount: orders.length,
      ),
    );
  }
}
