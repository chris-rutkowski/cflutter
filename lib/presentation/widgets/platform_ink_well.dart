import 'package:flutter/material.dart';

class PlatformInkWell extends StatelessWidget {
  final GestureTapCallback onTap;
  final Widget child;

  PlatformInkWell({Key key, this.onTap, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).platform == TargetPlatform.iOS
          ? Colors.transparent
          : Theme.of(context).splashColor,
      highlightColor: Theme.of(context).platform == TargetPlatform.iOS
          ? Theme.of(context).splashColor
          : Theme.of(context).highlightColor,
      onTap: onTap,
      child: child,
    );
  }
}
