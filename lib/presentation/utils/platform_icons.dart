import 'package:flutter/material.dart';

abstract class PlatformIcons {
  static IconData arrowBack(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS
        ? Icons.arrow_back_ios
        : Icons.arrow_back;
  }
}
