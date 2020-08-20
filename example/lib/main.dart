import 'package:cflutter/app.dart';
import 'package:cflutter/presentation/widgets/screen_scaffold/screen_scaffold.dart';
import 'package:cflutter/utils/enums.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ExampleApp());
}

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return App(
      theme: ThemeData.light(),
      home: ScreenScaffold(
        appBarTitle: 'Example',
        exitType: ExitType.hidden,
        children: (context) => [],
      ),
    );
  }
}
