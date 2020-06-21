import 'package:flutter/material.dart';
import '../providers/order.dart' as ord;

class OrderItem extends StatelessWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          children: [
            ListTile(
              title: Text('Total Amount: \$ ${order.totalAmount.toStringAsFixed(2)}'),
              subtitle: Text('Placed On: ${order.dateTime}'),
              trailing: IconButton(
                icon: Icon(Icons.expand_more),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
