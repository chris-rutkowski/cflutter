import 'package:flutter/material.dart';

class SpaceBetweenColumn extends StatelessWidget {
  final List<Widget> children;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final double spacing;

  SpaceBetweenColumn({
    Key? key,
    required this.children,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.spacing,
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
