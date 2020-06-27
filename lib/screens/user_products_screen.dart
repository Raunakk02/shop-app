import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_practice/providers/produts.dart';
import 'package:shop_practice/screens/edit_product_screen.dart';
import 'package:shop_practice/widgets/app_drawer.dart';
import 'package:shop_practice/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshUserProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetData(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
              //add product therefore no product id passed as argument
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshUserProducts(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshUserProducts(context),
                    child: Consumer<Products>(
                      builder: (ctx, productsData, _) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemBuilder: (ctx, index) {
                            return Column(
                              children: [
                                UserProductItem(
                                  productsData.items[index].id,
                                  productsData.items[index].title,
                                  productsData.items[index].imageUrl,
                                ),
                                Divider(),
                              ],
                            );
                          },
                          itemCount: productsData.items.length,
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
