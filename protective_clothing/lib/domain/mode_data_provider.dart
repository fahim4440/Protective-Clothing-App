import 'package:flutter/material.dart';

class ModeDataProvider extends ChangeNotifier {
  String _name = "";

  String get name => _name;

  set name(String newName) {
    _name = newName;
    notifyListeners();
  }
}