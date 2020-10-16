import 'package:flutter/foundation.dart';

class OnScreenLogger with ChangeNotifier {
  static final OnScreenLogger _singleton = OnScreenLogger._();

  var logs = <String>[];
  bool get visible => _hideDate != null;
  DateTime _hideDate;

  OnScreenLogger._();

  factory OnScreenLogger() => _singleton;

  void addLog(String log) async {
    logs.add(log);
    _hideDate = DateTime.now().add(Duration(seconds: 5));
    notifyListeners();

    while (_hideDate != null && _hideDate.isAfter(DateTime.now())) {
      await Future.delayed(Duration(seconds: 1));
    }

    _hideDate = null;

    notifyListeners();
  }
}
