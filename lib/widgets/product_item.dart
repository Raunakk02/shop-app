import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_practice/providers/auth.dart';
import 'package:shop_practice/providers/cart.dart';

import '../providers/product.dart';
import '../screens/products_detail_screen.dart';

class ProductItem extends StatefulWidget {
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final auth = Provider.of<Auth>(context, listen: false);
    var _isFavorite = product.isFavorite;

    final scaffold = Scaffold.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetailScreen.routeName,
          arguments: product.id,
        );
      },
      child: GridTile(
        child: Hero(
          tag: product.id,
          child: FadeInImage(
            placeholder: AssetImage('assets/images/ripple.gif'),
            image: NetworkImage(
              product.imageUrl,
            ),
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              product
                  .toggleFavoriteStatus(auth.token, auth.userId)
                  .catchError((error) {
                scaffold.removeCurrentSnackBar();
                scaffold.showSnackBar(
                  SnackBar(
                    content: Text(error.toString()),
                  ),
                );
              });
            },
            color: Theme.of(context).accentColor,
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () {
              Provider.of<Cart>(context, listen: false).addToCart(
                product.id,
                product.title,
                product.price,
              );
              Scaffold.of(context).removeCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added item to cart'),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      Provider.of<Cart>(context, listen: false)
                          .removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
