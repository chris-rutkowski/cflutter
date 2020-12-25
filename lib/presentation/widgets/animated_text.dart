import 'package:flutter/material.dart';

class AnimatedText extends StatefulWidget {
  final String data;
  final TextStyle style;
  final Duration duration;

  const AnimatedText(this.data, {Key key, this.style, @required this.duration}) : super(key: key);

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Color> colorAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Text(
          widget.data,
          style: widget.style?.copyWith(color: colorAnimation?.value),
        );
      },
    );
  }

  @override
  void didUpdateWidget(covariant AnimatedText oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.duration = widget.duration;
    colorAnimation = ColorTween(
      begin: oldWidget.style?.color,
      end: widget.style?.color,
    ).animate(controller);
    controller.forward(from: 0);
  }
}
