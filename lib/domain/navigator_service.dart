import 'package:flutter/material.dart';

class NavigatorService {
  static final navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> push(Widget widget) {
    return navigatorKey.currentState!.push(
      MaterialPageRoute(
        builder: (context) {
          return widget;
        },
      ),
    );
  }

  Future<dynamic> pushReplacement(Widget widget) {
    return navigatorKey.currentState!.pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return widget;
        },
      ),
    );
  }

  void pop() {
    navigatorKey.currentState!.pop();
  }

  void popToRoot() {
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
