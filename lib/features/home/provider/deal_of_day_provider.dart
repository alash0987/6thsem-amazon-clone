import 'package:amazonclone/models/product_model.dart';
import 'package:flutter/material.dart';

class DealOfDayProvider extends ChangeNotifier {
  Product? _dealOfDay;
  Product? get dealOfDay => _dealOfDay;
  set dealOfDaySet(Product? dealOfDay) {
    _dealOfDay = dealOfDay;
    notifyListeners();
  }
}
