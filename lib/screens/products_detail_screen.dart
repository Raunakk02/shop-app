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
      // appBar: AppBar(
      //   title: Text(selectedProd.title),
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(selectedProd.title),
              background: Container(
                height: 300,
                width: double.infinity,
                child: Hero(
                  tag: selectedProd.id,
                  child: Image.network(
                    selectedProd.imageUrl,
                    fit: BoxFit.cover,
                  ),
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
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10,
              ),
              Text(
                '\$ ${selectedProd.price}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
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
              SizedBox(height: 800,)
            ]),
          ),
        ],
      ),
    );
  }
}
