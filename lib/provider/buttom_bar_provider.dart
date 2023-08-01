import 'package:flutter/material.dart';

class ButtomBarProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  int _currentIndexAdmin = 0;
  int get currentIndexAdmin => _currentIndexAdmin;
  void changeIndexAdmin(int index) {
    _currentIndexAdmin = index;
    notifyListeners();
  }

  void changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
