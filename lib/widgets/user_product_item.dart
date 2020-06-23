import 'package:flutter/material.dart';

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
                onPressed: () {},
                color: Theme.of(context).primaryColor,
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                onPressed: () {},
                color: Theme.of(context).errorColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
