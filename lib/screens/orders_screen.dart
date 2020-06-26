import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_practice/widgets/order_item.dart';
import '../providers/order.dart' show Order;
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;

  @override
  void initState() {
    _isLoading = true;
    Future.delayed(Duration.zero).then((_) async {
      await Provider.of<Order>(context, listen: false).fetchAndSetData();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Order>(context).items;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return OrderItem(orders[index]);
              },
              itemCount: orders.length,
            ),
    );
  }
}
