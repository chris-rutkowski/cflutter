import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/theme/space.dart';
import 'loading_indicator.dart';

class LoadingView extends StatefulWidget {
  static var slowTitle = 'still working…';
  static var verySlowTitle = 'it is taking a little bit longer than usual…';

  final String? title;
  final String? inpatientLevel1Message; // has default value
  final String? inpatientLevel2Message; // has default value

  LoadingView({
    Key? key,
    this.title,
    this.inpatientLevel1Message,
    this.inpatientLevel2Message,
  }) : super(key: key);

  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> with TickerProviderStateMixin {
  final contentKey = GlobalKey();
  final stackKey = GlobalKey();

  Timer? inpatientTimer;
  late AnimationController inpatientController;
  late Animation<double> inpatientFadeIn;
  String? inpatientMsg;
  double? inpatientMsgPosition;

  @override
  void initState() {
    configureDelayedInpatientMsgs();

    inpatientController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    inpatientFadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(inpatientController)
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => calculateInpatientPosition(context));

    Widget? titleWidget;
    if (widget.title != null) {
      titleWidget = Padding(
        padding: EdgeInsets.only(top: medium),
        child: Text(
          widget.title!,
          style: Theme.of(context).textTheme.headline3,
          textAlign: TextAlign.center,
        ),
      );
    }

    var children = <Widget>[
      Positioned.fill(
        left: small,
        right: small,
        child: Center(
          child: Column(
            key: contentKey,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              LoadingIndicator(),
              titleWidget ?? Container(),
            ],
          ),
        ),
      ),
    ];

    if (inpatientMsgPosition != null && inpatientMsg != null) {
      children.add(
        Positioned(
          top: inpatientMsgPosition,
          left: small,
          right: small,
          child: Opacity(
            opacity: inpatientFadeIn.value,
            child: Text(
              inpatientMsg!,
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return Stack(
      key: stackKey,
      children: children,
    );
  }

  @override
  void dispose() {
    inpatientTimer?.cancel();
    inpatientController.dispose();
    super.dispose();
  }

  void configureDelayedInpatientMsgs() {
    inpatientTimer = Timer(Duration(seconds: 5), () {
      if (!mounted) {
        return;
      }

      setState(() {
        inpatientMsg = widget.inpatientLevel1Message ?? LoadingView.slowTitle;
        inpatientController.forward();
      });

      inpatientTimer = Timer(Duration(seconds: 5), () {
        if (!mounted) {
          return;
        }

        setState(() {
          inpatientMsg = widget.inpatientLevel2Message ?? LoadingView.verySlowTitle;
        });
      });
    });
  }

  void calculateInpatientPosition(BuildContext context) {
    var inpatientMsgPosition = 0.0;

    if (stackKey.currentContext != null && contentKey.currentContext != null) {
      final stackRB = stackKey.currentContext?.findRenderObject() as RenderBox?;
      final stackPosition = stackRB?.localToGlobal(Offset.zero);
      final contentRB = contentKey.currentContext?.findRenderObject() as RenderBox?;
      final contentPosition = contentRB?.localToGlobal(Offset.zero);
      final extraSpace = (widget.title == null) ? medium : xSmall;

      if (contentPosition == null || stackPosition == null || contentRB == null) {
        return;
      }
      inpatientMsgPosition = contentPosition.dy - stackPosition.dy + contentRB.size.height + extraSpace;
    }

    if (this.inpatientMsgPosition != inpatientMsgPosition) {
      setState(() {
        this.inpatientMsgPosition = inpatientMsgPosition;
      });
    }
  }
}
