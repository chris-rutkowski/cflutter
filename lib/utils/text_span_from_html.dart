import 'package:flutter/material.dart';

import 'indexed_iterable.dart';

List<TextSpan> textSpanFromHTML(String html) {
  final components = html.split(RegExp(r'<[/]?b>'));

  return components
      .mapIndexed(
        (i, e) => TextSpan(
            text: e,
            style: i.isOdd ? TextStyle(fontWeight: FontWeight.bold) : null),
      )
      .toList();
}
