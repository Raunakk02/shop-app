import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_practice/models/http_exception.dart';

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  String authToken;
  String userId;

  void updateProductsProperties(String token,String authUserId, List<Product> prevProductsList,) {
    authToken = token;
    _items = prevProductsList;
    userId = authUserId;
    notifyListeners();
  }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  Future<void> fetchAndSetData([bool productFilterOption = false]) async {

    var filterString = productFilterOption ? '&orderBy="creatorId"&equalTo="$userId"' : '';

    var url =
        'https://flutter-update-practice.firebaseio.com/products.json?auth=$authToken$filterString';

    final response = await http.get(url);

    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    if (extractedData == null) {
      return;
    }

    url = 'https://flutter-update-practice.firebaseio.com/userFavorites/$userId.json?auth=$authToken';

    final favResponse = await http.get(url);
    final favData = json.decode(favResponse.body);


    final List<Product> loadedProducts = [];

    extractedData.forEach((prodId, prodData) {
      loadedProducts.add(
        Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          imageUrl: prodData['imageUrl'],
          price: prodData['price'],
          isFavorite:favData == null ? false :  favData[prodId] == null ? false : favData[prodId],
        ),
      );
    });

    _items = loadedProducts;
    notifyListeners();
  }

  Future<Null> addProduct(Product product) async {
    final url =
        'https://flutter-update-practice.firebaseio.com/products.json?auth=$authToken';

    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'creatorId':userId,
          }));
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        isFavorite: product.isFavorite,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProduct(Product newProduct) async {
    final index = _items.indexWhere((prod) => prod.id == newProduct.id);
    if (index >= 0) {
      final url =
          'https://flutter-update-practice.firebaseio.com/products/${newProduct.id}.json?auth=$authToken';

      final oldProduct = _items[index];

      try {
        final response = await http.patch(
          url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
          }),
        );

        if (response.statusCode >= 400) {
          _items[index] = oldProduct;
        } else {
          _items[index] = newProduct;
        }
      } catch (error) {
        throw error;
      }
    }

    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    final index = _items.indexWhere((prod) => prod.id == id);
    final oldProduct = _items[index];
    _items.removeAt(index);
    notifyListeners();

    final url =
        'https://flutter-update-practice.firebaseio.com/products/$id.json?auth=$authToken';

    try {
      final response = await http.delete(url);
      if (response.statusCode >= 400) {
        _items.insert(index, oldProduct);
        notifyListeners();

        throw HttpException("Could not delete the product!");
      }
    } catch (error) {
      throw error;
    }
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }
}
