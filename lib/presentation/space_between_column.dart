import 'package:flutter/material.dart';

class SpaceBetweenColumn extends StatelessWidget {
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final double spacing;
  final List<Widget> children;

  SpaceBetweenColumn({
    Key? key,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.spacing,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    this.children.forEach((e) {
      if (children.isNotEmpty) {
        children.add(SizedBox(height: spacing));
      }
      children.add(e);
    });

    return Column(
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    );
  }
}
