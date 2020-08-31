import 'package:flutter/material.dart';

import '../utils/theme/space.dart';
import 'keys.dart' as K;

class Header extends StatelessWidget {
  static var headerToBodyMargin = small;

  final String text;
  final String body;

  /// Default Medium padding is to be used for very first header in the list
  /// subsequent headers should be spaced Large from the last item on the list.
  final double topPadding;

  Header({
    Key key,
    this.text,
    this.body,
    this.topPadding = medium,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: small,
        right: small,
        top: topPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            text,
            key: Key(K.Header.title),
            style: Theme.of(context).textTheme.headline2,
          ),
          Visibility(
            visible: body != null,
            child: Padding(
              padding: EdgeInsets.only(top: headerToBodyMargin),
              child: Text(
                body ?? '',
                key: Key(K.Header.body),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
