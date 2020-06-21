import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_practice/screens/orders_screen.dart';

import './providers/produts.dart';
import './providers/cart.dart';
import './providers/order.dart';

import './screens/products_overview_screen.dart';
import './screens/products_detail_screen.dart';
import './screens/carts_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => Order(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartsScreen.routeName: (ctx) => CartsScreen(),      
          OrdersScreen.routeName: (ctx) => OrdersScreen(),    
        },
      ),
    );
  }
}
