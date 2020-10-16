import 'package:cflutter/data/on_screen_logger.dart';
import 'package:cflutter/presentation/widgets/cell/cell.dart';
import 'package:cflutter/presentation/widgets/screen_scaffold/screen_scaffold.dart';
import 'package:flutter/material.dart';

class DemoOnScreenLogger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      appBarTitle: 'Demo OnScreenLogger',
      children: (context) => [
        Cell(
          header: 'Add short log',
          onTap: () => OnScreenLogger().addLog('dummy short log'),
        ),
        Cell(
          header: 'Add long log',
          onTap: () => OnScreenLogger().addLog(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis pulvinar elit leo, ut placerat mi faucibus tincidunt. Duis euismod egestas faucibus. Sed ac tempus orci. Mauris ultrices nibh fermentum felis luctus cursus. Etiam euismod efficitur condimentum. Curabitur eu diam eget lacus tincidunt pulvinar.'),
        ),
      ],
    );
  }
}
