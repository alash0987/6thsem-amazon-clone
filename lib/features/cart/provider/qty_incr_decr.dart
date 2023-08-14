import 'package:flutter/material.dart';

class QuantityIncreaseDecrease with ChangeNotifier {
  int _quantity = 1;
  int get quantity => _quantity;

  void increment() {
    _quantity++;
    notifyListeners();
  }

  void decrement() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }
}
