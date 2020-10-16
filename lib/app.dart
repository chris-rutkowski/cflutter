import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'data/on_screen_logger.dart';
import 'domain/navigator_service.dart';
import 'domain/providers/processing.dart';
import 'presentation/widgets/appearance_notifier.dart';
import 'presentation/widgets/on_screen_logger_view.dart';
import 'presentation/widgets/processing_view.dart';

class App extends StatelessWidget {
  final Widget home;
  final ThemeData theme;
  final ThemeData darkTheme;
  final ThemeMode themeMode;
  final List<SingleChildWidget> providers;
  final bool debugShowCheckedModeBanner;

  App({
    Key key,
    @required this.home,
    @required this.theme,
    this.darkTheme,
    this.themeMode,
    this.providers,
    this.debugShowCheckedModeBanner = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Processing>(
          create: (_) => Processing(),
          lazy: false,
        ),
        ChangeNotifierProvider<OnScreenLogger>(create: (_) => OnScreenLogger()),
        Provider(create: (_) => NavigatorService()),
        ...(providers ?? [])
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        navigatorKey: NavigatorService.navigatorKey,
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
              OnScreenLoggerView(),
            ],
          );
        },
        theme: theme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        home: home,
      ),
    );
  }
}
