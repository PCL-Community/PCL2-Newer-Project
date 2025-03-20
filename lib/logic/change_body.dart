import 'package:flutter/material.dart';

class MyListener extends ChangeNotifier {
  int currentPage = 1;
  int get getCurrentPage => currentPage;

  void setCurrentPage(int page) {
    currentPage = page;
    notifyListeners();
  }
}

MyListener myListener = MyListener();
