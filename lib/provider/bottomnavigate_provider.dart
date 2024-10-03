import 'package:flutter/material.dart';

class CurrentIndexProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void update(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
