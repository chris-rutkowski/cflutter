import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'domain/navigator_service.dart';
import 'domain/providers/processing.dart';
import 'presentation/widgets/appearance_notifier.dart';
import 'presentation/widgets/processing_view.dart';

class App extends StatelessWidget {
  final Widget home;
  final ThemeData theme;
  final List<SingleChildWidget> providers;

  App({
    Key key,
    @required this.home,
    @required this.theme,
    this.providers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Processing>(
          create: (_) => Processing(),
          lazy: false,
        ),
        Provider(create: (_) => NavigatorService()),
        ...(providers ?? [])
      ],
      child: MaterialApp(
        navigatorKey: NavigatorService.navigatorKey,
        navigatorObservers: [appearanceRouteObserver],
        builder: (context, navigator) {
          return Theme(
            data: theme,
            child: Stack(
              children: <Widget>[
                navigator,
                Consumer<Processing>(
                  builder: (context, model, _) {
                    return AnimatedOpacity(
                      opacity: model.processing == null ? 0 : 1,
                      duration: Duration(milliseconds: 300),
                      child: ProcessingView(
                        processingState: model.processing,
                        data: model.processingViewData,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
        home: home,
      ),
    );
  }
}
