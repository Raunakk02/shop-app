import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
              subtitle: Text(
                  'Placed On: ${DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)}'),
              trailing: IconButton(
                icon: _isExpanded
                    ? Icon(
                        Icons.expand_less,
                        color: Theme.of(context).accentColor,
                      )
                    : Icon(
                        Icons.expand_more,
                        color: Theme.of(context).accentColor,
                      ),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.linear,
              width: double.infinity,
              height: _isExpanded
                  ? min(widget.order.cartItems.length * 22.0 + 10, 180)
                  : 0,
              child: Scrollbar(
                child: ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 5),
                      child: Row(
                        children: [
                          Text(widget.order.cartItems[index].title),
                          Spacer(),
                          Text(
                              '${widget.order.cartItems[index].quantity} X \$${widget.order.cartItems[index].price}')
                        ],
                      ),
                    );
                  },
                  itemCount: widget.order.cartItems.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
