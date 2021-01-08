import 'package:flutter/material.dart';

class OptionalAnimationBuilder extends StatelessWidget {
  final Listenable animation;
  final TransitionBuilder builder;
  final Widget child;

  OptionalAnimationBuilder({Key key, this.animation, this.builder, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (animation == null) return child;
    return AnimatedBuilder(
      animation: animation,
      builder: builder,
      child: child,
    );
  }
}
