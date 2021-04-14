import 'package:flutter/material.dart';

import '../utils/theme/space.dart';
import 'keys.dart' as K;

class Header extends StatelessWidget {
  static var headerToBodyMargin = small;

  final text;
  final Widget? leading;
  final Widget? trailing;
  final body;

  /// Default Medium padding is to be used for very first header in the list
  /// subsequent headers should be spaced Large from the last item on the list.
  final double topPadding;

  Header({
    Key? key,
    this.text,
    this.leading,
    this.trailing,
    this.body,
    this.topPadding = medium,
  }) : super(key: key);

  Widget _leadingWithPadding(BuildContext context) {
    if (leading == null) return Container();
    return Padding(
      padding: EdgeInsets.only(right: small),
      child: leading,
    );
  }

  Widget _trailingWithPadding(BuildContext context) {
    if (trailing == null) return Container();
    return Padding(
      padding: EdgeInsets.only(left: small),
      child: trailing,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: EdgeInsets.only(
          left: small,
          right: small,
          top: topPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                _leadingWithPadding(context),
                Expanded(
                  child: _header(context),
                ),
                _trailingWithPadding(context),
              ],
            ),
            Visibility(
              visible: body != null,
              child: Padding(
                padding: EdgeInsets.only(top: headerToBodyMargin),
                child: _body(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    if (text is String) {
      return Text(
        text as String,
        key: Key(K.Header.title),
        style: Theme.of(context).textTheme.headline2,
      );
    } else if (text is Widget) {
      return text as Widget;
    } else {
      throw Exception('text can be either String or Widget');
    }
  }

  Widget? _body(BuildContext context) {
    if (body is String) {
      return Text(
        (body as String),
        key: Key(K.Header.body),
        style: Theme.of(context).textTheme.bodyText1,
      );
    } else if (body is RichText) {
      return Stack(
        children: [
          body as Widget,
          Text(
            (body as RichText).text.toPlainText(),
            key: Key(K.Header.body),
            style: TextStyle(fontSize: 1, color: Colors.transparent),
          ),
        ],
      );
    } else if (body is Widget) {
      return (body as Widget);
    } else if (body == null) {
      return null;
    } else {
      throw Exception('body can be either String, RichText or Widget');
    }
  }
}
