import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

String prettyJson(dynamic value) {
  try {
    final encoder = JsonEncoder.withIndent('  ');

    if (value is String) {
      final decoder = JsonDecoder();
      return encoder.convert(decoder.convert(value));
    } else {
      return encoder.convert(value);
    }
  } catch (_) {
    return value as String;
  }
}

void debugPrintJson(dynamic value) {
  if (kReleaseMode) return;
  prettyJson(value).split('\n').forEach((element) => debugPrint(element));
}
