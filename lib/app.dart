import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'domain/navigator_service.dart';
import 'domain/providers/processing.dart';
import 'presentation/widgets/appearance_notifier.dart';
import 'presentation/widgets/processing_view.dart';

class App extends StatelessWidget {
  final Widget home;

  App({Key key, this.home}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Processing>(
          create: (_) => Processing(),
          lazy: false,
        ),
        Provider(
          create: (_) => NavigatorService(),
        )
      ],
      child: MaterialApp(
        navigatorKey:
            Provider.of<NavigatorService>(context, listen: false).navigatorKey,
        navigatorObservers: [appearanceRouteObserver],
        builder: (context, navigator) {
          return Stack(
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
          );
        },
        home: home,
      ),
    );
  }
}
