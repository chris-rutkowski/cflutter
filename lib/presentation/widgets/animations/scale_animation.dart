import 'package:flutter/material.dart';

class ScaleAnimation extends StatefulWidget {
  final Widget? child;
  final double scale;
  final Duration duration;

  ScaleAnimation({
    Key? key,
    this.child,
    this.scale = 0.8,
    this.duration = const Duration(seconds: 1),
  }) : super(key: key);

  @override
  _ScaleAnimationState createState() => _ScaleAnimationState();
}

class _ScaleAnimationState extends State<ScaleAnimation> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: widget.duration, vsync: this);
    animation = Tween<double>(begin: 1, end: widget.scale).animate(controller);

    controller.forward();
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Transform.scale(
          scale: animation.value,
          child: widget.child,
        );
      },
    );
  }

  @override
  void didUpdateWidget(ScaleAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      controller.duration = widget.duration;
    }

    if (oldWidget.scale != widget.scale) {
      animation = Tween<double>(begin: 1, end: widget.scale).animate(controller);
    }
  }
}
