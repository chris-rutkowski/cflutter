import 'package:flutter/material.dart';

import '../../presentation/widgets/processing_view.dart';

class Processing with ChangeNotifier {
  ProcessingState get processing => _processing;
  ProcessingState _processing;

  String _processingTitle;
  String _completedTitle;

  ProcessingViewData get processingViewData => ProcessingViewData(
      processingTitle: _processingTitle, completedTitle: _completedTitle);

  void start(String title) {
    _processingTitle = title;
    _processing = ProcessingState.processing;
    notifyListeners();
  }

  void complete(String title) async {
    _completedTitle = title;
    _processing = ProcessingState.completed;
    notifyListeners();

    await Future.delayed(Duration(seconds: 2));
    _processing = null;
    notifyListeners();
  }

  void cancel() {
    _processing = null;
    notifyListeners();
  }
}
