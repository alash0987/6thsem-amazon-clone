import 'package:flutter/material.dart';

class StepperProvider extends ChangeNotifier {
  int _currentStep = 0;
  int get currentStep => _currentStep;
  set currentStepSeter(int value) => _currentStep = value;
}
