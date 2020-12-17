import 'package:flutter/material.dart';

import 'indexed_iterable.dart';

List<TextSpan> textSpanFromHTML(String html, {FontWeight boldFontWeight = FontWeight.bold}) {
  return html
      .split(RegExp(r'<[/]?b>'))
      .mapIndexed(
        (i, e) => TextSpan(text: e, style: i.isOdd ? TextStyle(fontWeight: boldFontWeight) : null),
      )
      .toList();
}
