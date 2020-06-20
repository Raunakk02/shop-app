import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_practice/providers/produts.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments;
    final selectedProd = Provider.of<Products>(context).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedProd.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedProd.imageUrl,
                fit: BoxFit.cover,
              ),
              decoration: BoxDecoration(
                border: Border.symmetric(
                  vertical: BorderSide(
                    color: Colors.grey,
                    width: 8,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '\$ ${selectedProd.price}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                selectedProd.description,
                style: TextStyle(
                  color: Colors.grey[900],
                ),
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
