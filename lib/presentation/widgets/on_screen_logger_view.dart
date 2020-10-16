import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/on_screen_logger.dart';

class OnScreenLoggerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<OnScreenLogger>(
      builder: (context, logger, _) {
        if (!logger.visible) return IgnorePointer();

        return IgnorePointer(
          child: SafeArea(
            child: Container(
              color: Colors.white.withOpacity(0.5),
              child: ListView(
                children: OnScreenLogger()
                    .logs
                    .reversed
                    .map((e) => Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                e,
                                style: Theme.of(context).textTheme.headline3.copyWith(color: Colors.black),
                              ),
                            ),
                            Divider()
                          ],
                        ))
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
