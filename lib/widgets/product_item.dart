import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


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
    var _isFavorite = product.isFavourite;
    
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetailScreen.routeName,
          arguments: product.id,
        );
      },
      child: GridTile(
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              product.toggleFavoriteStatus();
            },
            color: Theme.of(context).accentColor,
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
