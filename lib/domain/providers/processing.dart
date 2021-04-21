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
  Widget? _completedChild;

  ProcessingViewData get processingViewData => ProcessingViewData(
        processingTitle: _processingTitle,
        completedTitle: _completedTitle,
        completedIcon: _completedIcon,
        completedChild: _completedChild,
      );

  void start(String title) {
    _processingTitle = title;
    _processing = ProcessingState.processing;
    notifyListeners();
  }

  void complete(
    String title, {
    IconData icon = Icons.cloud_done,
    Widget? child,
  }) async {
    _completedTitle = title;
    _completedIcon = icon;
    _completedChild = child;
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
