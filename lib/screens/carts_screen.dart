import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_practice/providers/order.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';

class CartsScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<Cart>(context);

    final cartItemsValues = cartProvider.items.values.toList();
    final cartItemsKeys = cartProvider.items.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Column(
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.all(15),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount ',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    backgroundColor: Theme.of(context).primaryColor,
                    label: Text(
                      '\$ ${cartProvider.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      if(cartItemsValues.isEmpty){
                        return;
                      }
                      Provider.of<Order>(context,listen: false).addOrder(
                        cartItemsValues,
                        cartProvider.totalAmount,
                      );
                      cartProvider.clearCart();
                    },
                    child: Text('ORDER NOW'),
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return CartItem(
                    cartItemsKeys[index],
                    cartItemsValues[index].title,
                    cartItemsValues[index].price,
                    cartItemsValues[index].quantity);
              },
              itemCount: cartProvider.items.length,
            ),
          ),
        ],
      ),
    );
  }
}
