import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_practice/widgets/splash_screen.dart';

import './providers/auth.dart';
import './providers/produts.dart';
import './providers/cart.dart';
import './providers/order.dart';

import './screens/auth_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/products_detail_screen.dart';
import './screens/carts_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products(),
          update: (_, auth, previousProducts) => Products()
            ..updateProductsProperties(
              auth.token,
              auth.userId,
              previousProducts == null ? [] : previousProducts.items,
            ),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Order>(
          create: (_) => Order(),
          update: (_, auth, prevOrder) => Order()
            ..updateOrderProperties(
              auth.token,
              auth.userId,
              prevOrder == null ? [] : prevOrder.items,
            ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
          ),
          home: auth.isAuth
              ? ProductsOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authSnapshot) =>
                      authSnapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartsScreen.routeName: (ctx) => CartsScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
