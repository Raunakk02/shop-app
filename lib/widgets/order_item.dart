import 'dart:math';

import 'package:flutter/material.dart';
import '../providers/order.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          children: [
            ListTile(
              title: Text(
                  'Total Amount: \$ ${widget.order.totalAmount.toStringAsFixed(2)}'),
              subtitle: Text('Placed On: ${widget.order.dateTime}'),
              trailing: IconButton(
                icon: _isExpanded
                    ? Icon(Icons.expand_less)
                    : Icon(Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
              ),
            ),
            if (_isExpanded)
              Container(
                width: double.infinity,
                height: min(widget.order.cartItems.length * 20.0 + 10, 100),
                child: ListView.builder(
                  itemBuilder: (ctx,index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 5),
                      child: Row(
                        children: [
                          Text(widget.order.cartItems[index].title),
                          Spacer(),
                          Text('${widget.order.cartItems[index].quantity} X \$${widget.order.cartItems[index].price}')
                        ],
                      ),
                    );
                  },
                  itemCount: widget.order.cartItems.length,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
