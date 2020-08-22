import 'package:flutter/material.dart';

class PlatformInkWell extends StatelessWidget {
  final BorderRadius borderRadius;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;
  final Widget child;

  PlatformInkWell({
    Key key,
    this.borderRadius,
    this.onTap,
    this.onLongPress,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: borderRadius,
      splashColor: Theme.of(context).platform == TargetPlatform.iOS
          ? Colors.transparent
          : Theme.of(context).splashColor,
      highlightColor: Theme.of(context).platform == TargetPlatform.iOS
          ? Theme.of(context).splashColor
          : Theme.of(context).highlightColor,
      onTap: onTap,
      onLongPress: onLongPress,
      child: child,
    );
  }
}
