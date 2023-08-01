import 'package:flutter/material.dart';

class DropdownProvider extends ChangeNotifier {
  List<String> productCatagories = [
    'Mobiles',
    'Essentiels',
    'Appliances',
    'Books',
    'Fashion'
  ];
  String _selectedCategory = 'Mobiles';
  String get selectedCategory => _selectedCategory;

  changeSelectedCategory(String? newCategory) {
    _selectedCategory = newCategory!;
    notifyListeners();
  }
}
