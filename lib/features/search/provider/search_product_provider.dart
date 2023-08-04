import 'package:amazonclone/models/product_model.dart';
import 'package:flutter/material.dart';

class SearchProductProvider extends ChangeNotifier {
  List<Product> _searchProduct = [];
  List<Product> get searchProduct => _searchProduct;
  set searchProductSet(List<Product> searchProducts) {
    _searchProduct = searchProducts;
    notifyListeners();
  }
}
