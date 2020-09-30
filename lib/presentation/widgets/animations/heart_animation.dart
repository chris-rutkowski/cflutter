import 'package:flutter/material.dart';

class HeartAnimation extends StatefulWidget {
  final Widget child;
  final double firstScale;
  final double secondScale;

  HeartAnimation({
    Key key,
    this.child,
    this.firstScale = 0.8,
    this.secondScale = 0.7,
  }) : super(key: key);

  @override
  _HeartAnimationState createState() => _HeartAnimationState();
}

class _HeartAnimationState extends State<HeartAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    controller.forward();
    controller.addListener(() => setState(() => {}));
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.forward(from: 0);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  double get scale {
    final firstScale = widget.firstScale;
    final secondScale = widget.secondScale;
    if (controller.value < 0.15) {
      final value = 1 - controller.value / 0.15;
      return firstScale + (1 - firstScale) * value;
    } else if (controller.value < 0.3) {
      final value = (controller.value - 0.15) / 0.15;
      return firstScale + (1 - firstScale) * value;
    } else if (controller.value < 0.45) {
      final value = 1 - (controller.value - 0.3) / 0.15;
      return secondScale + (1 - secondScale) * value;
    } else if (controller.value < 0.60) {
      final value = (controller.value - 0.45) / 0.15;
      return secondScale + (1 - secondScale) * value;
    } else {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: widget.child,
    );
  }
}
