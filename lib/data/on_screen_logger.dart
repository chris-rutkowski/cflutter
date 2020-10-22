import 'package:flutter/foundation.dart';

class OnScreenLogger with ChangeNotifier {
  static OnScreenLogger singleton;

  var logs = <String>[];
  bool get visible => _hideDate != null;
  DateTime _hideDate;

  OnScreenLogger._();

  factory OnScreenLogger() {
    if (singleton != null) {
      return singleton;
    }

    final logger = OnScreenLogger._();
    singleton = logger;
    return logger;
  }

  @override
  void dispose() {
    singleton = null;
    super.dispose();
  }

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
