import 'package:amazonclone/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  List<Product>? _products = [];
  List<Product>? get products => _products;
  set productsSet(List<Product>? products) {
    _products = products;
    notifyListeners();
  }

  List<Product> _categoryProducts = [];
  List<Product> get categoryProducts => _categoryProducts;
  set categoryProductsSet(List<Product> categoryProducts) {
    _categoryProducts = categoryProducts;
    notifyListeners();
  }
}
