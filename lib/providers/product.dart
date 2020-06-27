import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_practice/models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.price,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus(String authToken, String userId) async {
    this.isFavorite = !this.isFavorite;
    notifyListeners();

    final url =
        'https://flutter-update-practice.firebaseio.com/userFavorites/$userId/$id.json?auth=$authToken';

    try {
      final response = await http.put(
        url,
        body: json.encode(this.isFavorite),
      );

      if(response.statusCode >= 400){
        this.isFavorite = !this.isFavorite;
        notifyListeners();
        throw HttpException("Cannot update favorite status!");
      }
    } catch (error) {
      throw error;
    }
  }
}
