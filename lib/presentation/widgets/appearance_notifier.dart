import 'package:flutter/material.dart';

final RouteObserver<PageRoute> appearanceRouteObserver =
    RouteObserver<PageRoute>();

class AppearanceNotifier extends StatefulWidget {
  final Function(bool) onAppearanceChanged;
  final Widget child;

  AppearanceNotifier({
    this.onAppearanceChanged,
    @required this.child,
  });

  @override
  _AppearanceNotifierState createState() => _AppearanceNotifierState();
}

class _AppearanceNotifierState extends State<AppearanceNotifier>
    with RouteAware {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    try {
      appearanceRouteObserver.subscribe(
          this, ModalRoute.of(context) as PageRoute);
    } catch (_) {
      // during unit/widget tests the routes are not configured
    }
  }

  @override
  void dispose() {
    try {
      appearanceRouteObserver.unsubscribe(this);
    } catch (_) {
      // during unit/widget tests the routes are not configured
    }

    super.dispose();
  }

  @override
  void didPush() {
    if (widget.onAppearanceChanged != null) widget.onAppearanceChanged(true);
  }

  @override
  void didPopNext() async {
    // This delay forces more logical order of events, because otherwise during
    // pop event the following order would be:
    // 1. screen being displayed after pop completes
    // 2. popped (dismissed) screen
    await Future.delayed(Duration(milliseconds: 100));
    if (widget.onAppearanceChanged != null) widget.onAppearanceChanged(true);
  }

  @override
  void didPop() {
    if (widget.onAppearanceChanged != null) widget.onAppearanceChanged(false);
  }

  @override
  void didPushNext() {
    if (widget.onAppearanceChanged != null) widget.onAppearanceChanged(false);
  }
}
