import 'package:amazonclone/models/order.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  List<Order> _orders = [];
  List<Order> get orders => _orders;
  set ordersSet(List<Order> orders) {
    _orders = orders;
    notifyListeners();
  }
}
