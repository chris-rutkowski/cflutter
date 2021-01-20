import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'domain/navigator_service.dart';
import 'domain/providers/processing.dart';
import 'presentation/widgets/appearance_notifier.dart';
import 'presentation/widgets/processing_view.dart';

class App extends StatelessWidget {
  final TransitionBuilder builder;
  final Locale locale;
  final Widget home;
  final ThemeData theme;
  final ThemeData darkTheme;
  final ThemeMode themeMode;
  final List<SingleChildWidget> providers;
  final bool debugShowCheckedModeBanner;
  final Map<String, WidgetBuilder> routes;
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final Iterable<Locale> supportedLocales;

  App({
    Key key,
    this.builder,
    this.locale,
    @required this.home,
    @required this.theme,
    this.darkTheme,
    this.themeMode,
    this.providers,
    this.debugShowCheckedModeBanner = true,
    this.routes = const <String, WidgetBuilder>{},
    this.localizationsDelegates,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
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
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        locale: locale,
        routes: routes,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        navigatorKey: NavigatorService.navigatorKey,
        navigatorObservers: [appearanceRouteObserver],
        builder: (context, navigator) {
          if (builder != null) {
            return builder(context, _content(context, navigator));
          }
          return _content(context, navigator);
        },
        theme: theme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        home: home,
      ),
    );
  }

  Widget _content(BuildContext context, Widget navigator) {
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
  }
}
