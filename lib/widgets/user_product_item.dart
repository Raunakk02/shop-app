import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_practice/providers/produts.dart';
import 'package:shop_practice/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(title),
        trailing: FittedBox(
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProductScreen.routeName,arguments: id);
                },
                color: Theme.of(context).primaryColor,
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                onPressed: () {
                },
                color: Theme.of(context).errorColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
