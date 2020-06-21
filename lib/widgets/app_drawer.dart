import 'package:flutter/material.dart';
import 'package:shop_practice/screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello User!'),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pushReplacementNamed('/');
            },
            leading: Icon(
              Icons.shopping_basket,
              size: 40,
            ),
            title: Text(
              'Shop',
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ),
          Divider(
            thickness: 2,
            indent: 60,
          ),
          ListTile(
            onTap: (){
              Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
            },
            leading: Icon(
              Icons.payment,
              size: 40,
            ),
            title: Text(
              'My Orders',
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ),
          Divider(
            thickness: 2,
            indent: 60,
          ),
        ],
      ),
    );
  }
}
