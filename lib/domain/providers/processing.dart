import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/widgets/processing_view.dart';

class Processing with ChangeNotifier {
  ProcessingState? get processing => _processing;
  ProcessingState? _processing;

  static Processing of(BuildContext context) => Provider.of<Processing>(context, listen: false);

  String? _processingTitle;
  String? _completedTitle;
  IconData? _completedIcon;

  ProcessingViewData get processingViewData => ProcessingViewData(
      processingTitle: _processingTitle, completedTitle: _completedTitle, completedIcon: _completedIcon);

  void start(String title) {
    _processingTitle = title;
    _processing = ProcessingState.processing;
    notifyListeners();
  }

  void complete(
    String title, {
    IconData completedIcon = Icons.cloud_done,
  }) async {
    _completedTitle = title;
    _completedIcon = completedIcon;
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
