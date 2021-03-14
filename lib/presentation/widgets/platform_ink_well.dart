import 'package:flutter/material.dart';

class PlatformInkWell extends StatelessWidget {
  final BorderRadius? borderRadius;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final Widget? child;
  final Color? highlightColor;
  final Color? splashColor;

  PlatformInkWell({
    Key? key,
    this.borderRadius,
    this.onTap,
    this.onLongPress,
    this.child,
    this.highlightColor,
    this.splashColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: borderRadius,
      splashColor: Theme.of(context).platform == TargetPlatform.iOS
          ? Colors.transparent
          : splashColor ?? Theme.of(context).splashColor,
      highlightColor: Theme.of(context).platform == TargetPlatform.iOS
          ? splashColor ?? Theme.of(context).splashColor
          : highlightColor ?? Theme.of(context).highlightColor,
      onTap: onTap,
      onLongPress: onLongPress,
      child: child,
    );
  }
}
