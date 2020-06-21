import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_practice/providers/cart.dart';
import 'package:shop_practice/screens/carts_screen.dart';
import 'package:shop_practice/widgets/app_drawer.dart';
import 'package:shop_practice/widgets/badge.dart';

import '../providers/produts.dart';

import '../widgets/product_item.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavorites = false;

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);

    final loadedProducts = _showFavorites
        ? productsProvider.favoriteItems
        : productsProvider.items;

    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (selectedFilter) {
              setState(() {
                if (selectedFilter == FilterOptions.Favorite) {
                  _showFavorites = true;
                } else {
                  _showFavorites = false;
                }
              });
            },
            child: Icon(Icons.more_vert),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text('Show Favorite Products'),
                value: FilterOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text('Show All Products'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (ctx,cart,staticChild) => Badge(
              baseIconWidget: staticChild,
              data: cart.noOfItemsInCart.toString(),
            ),
            child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  //...take to cart screen
                  Navigator.of(context).pushNamed(CartsScreen.routeName);
                },
                alignment: Alignment.bottomCenter,
              ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: GridView.builder(
        itemBuilder: (ctx, index) {
          return ChangeNotifierProvider.value(
            value: loadedProducts[index],
            child: ProductItem(),
          );
        },
        itemCount: loadedProducts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        padding: const EdgeInsets.all(10),
      ),
    );
  }
}
