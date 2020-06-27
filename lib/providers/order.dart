import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_practice/widgets/order_item.dart';

import '../providers/cart.dart';

class OrderItem {
  final String id;
  final List<CartItem> cartItems;
  final double totalAmount;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.cartItems,
    @required this.dateTime,
    @required this.totalAmount,
  });
}

class Order with ChangeNotifier {
  List<OrderItem> _items = [];

  String authToken;
  String userId;

  void updateOrderProperties(
    String token,
    String authUserId,
    List<OrderItem> prevOrders,
  ) {
    authToken = token;
    userId = authUserId;
    _items = prevOrders;
  }

  List<OrderItem> get items {
    return [..._items];
  }

  Future<void> addOrder(List<CartItem> cartItems, double total) async {
    final url =
        'https://flutter-update-practice.firebaseio.com/orders/$userId.json?auth=$authToken';
    final timestamp = DateTime.now();

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'totalAmount': total,
          'dateTime': timestamp.toIso8601String(),
          'cartItems': cartItems
              .map((item) => {
                    'id': item.id,
                    'title': item.title,
                    'price': item.price,
                    'quantity': item.quantity,
                  })
              .toList(),
        }),
      );
      _items.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          cartItems: cartItems,
          totalAmount: total,
          dateTime: timestamp,
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAndSetData() async {
    final List<OrderItem> loadedOrders = [];

    final url =
        'https://flutter-update-practice.firebaseio.com/orders/$userId.json?auth=$authToken';

    try {
      final response = await http.get(url);

      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) {
        return;
      }

      extractedData.forEach((orderId, orderData) {
        loadedOrders.add(
          OrderItem(
            id: orderId,
            dateTime: DateTime.parse(orderData['dateTime']),
            totalAmount: orderData['totalAmount'],
            cartItems: (orderData['cartItems'] as List<dynamic>)
                .map(
                  (item) => CartItem(
                    id: item['id'],
                    title: item['title'],
                    price: item['price'],
                    quantity: item['quantity'],
                  ),
                )
                .toList(),
          ),
        );
      });

      _items = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
