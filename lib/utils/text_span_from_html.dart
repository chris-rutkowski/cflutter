import 'package:flutter/material.dart';

import 'indexed_iterable.dart';

List<TextSpan> textSpanFromHTML(String html) {
  return html
      .split(RegExp(r'<[/]?b>'))
      .mapIndexed(
        (i, e) => TextSpan(text: e, style: i.isOdd ? TextStyle(fontWeight: FontWeight.bold) : null),
      )
      .toList();
}
