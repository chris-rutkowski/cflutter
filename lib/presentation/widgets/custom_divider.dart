import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final bool error;
  final bool focus;

  CustomDivider({
    Key? key,
    this.error = false,
    this.focus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final thickness = error ? 2.0 : Theme.of(context).dividerTheme.thickness;

    return Divider(
      thickness: thickness,
      height: thickness,
      color: error
          ? Theme.of(context).colorScheme.error
          : focus
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).dividerTheme.color,
    );
  }
}
