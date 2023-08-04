import 'package:flutter/material.dart';

class RatingProvider extends ChangeNotifier {
  double _avgRating = 0;
  double get avgRating => _avgRating;
  double _myRating = 0;
  double get myRating => _myRating;
  double _totalRating = 0;
  double get totalRating => _totalRating;
  updateAvgRating(double uprate) {
    _avgRating = uprate;
    notifyListeners();
  }

  updateMyRating(double uprate) {
    _myRating = uprate;
    notifyListeners();
  }

  updateTotalRating(double totalrate) {
    _totalRating = totalrate;
    notifyListeners();
  }
}
