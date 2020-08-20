import 'package:cflutter/app.dart';
import 'package:cflutter/presentation/widgets/cell/cell.dart';
import 'package:cflutter/presentation/widgets/screen_scaffold/screen_scaffold.dart';
import 'package:cflutter/utils/enums.dart';
import 'package:flutter/material.dart';

import 'demo_internet_waiter.dart';
import 'theme/theme.dart';

void main() {
  runApp(ExampleApp());
}

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return App(
      theme: lightTheme(),
      home: ScreenScaffold(
        appBarTitle: 'Example',
        exitType: ExitType.hidden,
        children: (context) => [
          Cell(
            header: 'Demo internet waiter',
            accessory: ChevronAccessory(),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => DemoInternetWaiter())),
          )
        ],
      ),
    );
  }
}
