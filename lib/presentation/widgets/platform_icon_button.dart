import 'package:flutter/material.dart';

class PlatformIconButton extends StatelessWidget {
  PlatformIconButton({
    Key? key,
    required this.iconData,
    this.onPressed,
    this.textColor,
  }) : super(key: key);

  final IconData iconData;
  final VoidCallback? onPressed;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return _IOSPlatformIconButton(
        iconData: iconData,
        onPressed: onPressed,
        textColor: textColor,
      );
    } else {
      return IconButton(
        icon: Icon(
          iconData,
          color: textColor ?? Theme.of(context).iconTheme.color,
        ),
        onPressed: onPressed,
      );
    }
  }
}

class _IOSPlatformIconButton extends StatefulWidget {
  final IconData iconData;
  final VoidCallback? onPressed;
  final Color? textColor;

  _IOSPlatformIconButton({
    Key? key,
    required this.iconData,
    this.onPressed,
    this.textColor,
  }) : super(key: key);

  @override
  __IOSPlatformIconButtonState createState() => __IOSPlatformIconButtonState();
}

class __IOSPlatformIconButtonState extends State<_IOSPlatformIconButton> {
  bool isHighlighted = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.textColor ?? Theme.of(context).textTheme.button?.color;
    Widget button = Semantics(
      button: true,
      child: Container(
        width: 48.0,
        height: 48.0,
        alignment: Alignment.center,
        child: AnimatedSwitcher(
          duration: kThemeChangeDuration,
          child: KeyedSubtree(
            key: ValueKey<int>(isHighlighted ? 1 : 0),
            child: Icon(
              widget.iconData,
              color: isHighlighted ? color?.withOpacity(0.2) : color,
            ),
          ), // used by all buttons
        ),
      ),
    );

    return InkResponse(
      onTap: widget.onPressed,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onHighlightChanged: (bool value) {
        setState(() {
          isHighlighted = value;
        });
      },
      child: button,
    );
  }
}
