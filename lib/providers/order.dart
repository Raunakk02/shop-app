import 'package:flutter/foundation.dart';
import 'package:shop_practice/providers/cart.dart';

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

  List<OrderItem> get items {
    return [..._items];
  }

  void addOrder(List<CartItem> cartItems, double total) {
    _items.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        cartItems: cartItems,
        totalAmount: total,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }

}
