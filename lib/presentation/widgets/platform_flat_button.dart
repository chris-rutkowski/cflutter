import 'package:flutter/material.dart';

class PlatformFlatButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final VoidCallback onPressed;
  final TextStyle textStyle;

  PlatformFlatButton({Key key, this.text, this.textColor, this.onPressed, this.textStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final templateTextStyle = this.textStyle ?? Theme.of(context).textTheme.headline3;
    final textStyle = TextStyle(
      fontWeight: templateTextStyle.fontWeight,
      fontSize: templateTextStyle.fontSize,
      height: 1,
    );

    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return _IOSPlatformFlatButton(
        text: text,
        textColor: textColor,
        onPressed: onPressed,
        textStyle: textStyle,
      );
    } else {
      return FlatButton(
        onPressed: onPressed,
        textColor: textColor ?? Theme.of(context).textTheme.button.color,
        child: Text(
          text,
          style: textStyle,
          textAlign: TextAlign.center,
        ),
        disabledTextColor: Theme.of(context).disabledColor,
      );
    }
  }
}

class _IOSPlatformFlatButton extends StatefulWidget {
  final String text;
  final Color textColor;
  final VoidCallback onPressed;
  final TextStyle textStyle;

  _IOSPlatformFlatButton({
    Key key,
    this.text,
    this.textColor,
    this.onPressed,
    this.textStyle,
  }) : super(key: key);

  @override
  __IOSPlatformFlatButtonState createState() => __IOSPlatformFlatButtonState();
}

class __IOSPlatformFlatButtonState extends State<_IOSPlatformFlatButton> {
  bool isHighlighted = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onHighlightChanged: (value) {
        setState(() {
          isHighlighted = value;
        });
      },
      child: AnimatedSwitcher(
        child: KeyedSubtree(
          key: ValueKey<int>(isHighlighted ? 1 : 0),
          child: Text(
            widget.text,
            style: widget.textStyle.copyWith(color: _textColor),
            textAlign: TextAlign.center,
          ),
        ),
        duration: Duration(milliseconds: 200),
      ),
      onPressed: widget.onPressed,
    );
  }

  Color get _textColor {
    if (widget.onPressed == null) {
      return Theme.of(context).disabledColor;
    }

    final color = widget.textColor ?? Theme.of(context).textTheme.button.color;
    return isHighlighted ? color.withOpacity(0.2) : color;
  }
}
