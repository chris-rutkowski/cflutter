import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../utils/theme/space.dart';
import 'loading_view.dart';

enum ProcessingState { processing, completed }

class ProcessingViewData {
  final String processingTitle;
  final String completedTitle;
  final IconData completedIcon;

  ProcessingViewData({
    this.processingTitle,
    this.completedTitle,
    this.completedIcon = Icons.cloud_done,
  });
}

class ProcessingView extends StatefulWidget {
  final ProcessingState processingState; // nullable
  final ProcessingViewData data;

  ProcessingView({
    Key key,
    this.processingState,
    @required this.data,
  }) : super(key: key);

  @override
  _ProcessingViewState createState() => _ProcessingViewState();
}

class _ProcessingViewState extends State<ProcessingView>
    with TickerProviderStateMixin {
  AnimationController completedController;
  Animation<double> processingFadeOut;
  Animation<double> completedFadeIn;
  Animation<double> completedMoveUp;

  AnimationController processingController;
  Animation<double> processingFadeIn;

  AnimationController glassFadeInController;
  Animation<double> glassFadeIn;

  final processingViewColumnKey = GlobalKey();
  final stackKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    completedController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this)
      ..addListener(() {
        setState(() {});
      });

    processingFadeOut = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: completedController,
        curve: Interval(0.0, 0.3, curve: Curves.linear),
      ),
    );

    completedFadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: completedController,
        curve: Interval(0.1, 0.4, curve: Curves.linear),
      ),
    );

    completedMoveUp = Tween<double>(begin: 100, end: 0).animate(
      CurvedAnimation(
        parent: completedController,
        curve: Interval(0.1, 0.9, curve: Curves.easeOutBack),
      ),
    );

    processingController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this)
      ..addListener(() {
        setState(() {});
      });

    processingFadeIn = Tween<double>(begin: 0.0, end: 1).animate(
      CurvedAnimation(
        parent: processingController,
        curve: Interval(0.0, 0.3, curve: Curves.linear),
      ),
    );

    glassFadeInController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this)
      ..addListener(() {
        setState(() {});
      });

    glassFadeIn = Tween<double>(begin: 0.0, end: 1).animate(
      CurvedAnimation(
        parent: glassFadeInController,
        curve: Interval(0.0, 0.3, curve: Curves.linear),
      ),
    );
  }

  @override
  void dispose() {
    glassFadeInController.dispose();
    processingController.dispose();
    completedController.dispose();
    super.dispose();
  }

  Widget completedView(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          widget.data.completedIcon,
          color: Theme.of(context).colorScheme.primary,
          size: 96,
        ),
        SizedBox(height: medium),
        Text(
          widget.data.completedTitle ?? '',
          style: Theme.of(context).textTheme.headline3,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  void didUpdateWidget(ProcessingView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.processingState == null) {
    } else if (oldWidget.processingState == ProcessingState.processing &&
        widget.processingState == ProcessingState.completed) {
      glassFadeInController.value = 1;
      processingController.value = 1;
      completedController.forward();
    } else if (oldWidget.processingState == null &&
        widget.processingState == ProcessingState.processing) {
      processingController.forward(from: 0);
      glassFadeInController.forward(from: 0);
      completedController.reset();
    } else if (oldWidget.processingState == null &&
        widget.processingState == ProcessingState.completed) {
      processingController.reset();
      glassFadeInController.forward(from: 0);
      completedController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[
      WillPopScope(
        child: Container(),
        onWillPop: () async => false,
      )
    ];

    if (widget.processingState != null) {
      children.add(_Glass(
        fadeIn: glassFadeIn.value,
      ));
      children.add(
        Opacity(
          opacity: processingFadeOut.value,
          child: Opacity(
            opacity: processingFadeIn.value,
            child: LoadingView(
              title: widget.data.processingTitle,
            ),
          ),
        ),
      );
      children.add(
        Positioned.fill(
          top: completedMoveUp.value,
          left: small,
          right: small,
          child: Opacity(
            opacity: completedFadeIn.value,
            child: Center(child: completedView(context)),
          ),
        ),
      );
    }

    return Stack(
      key: stackKey,
      alignment: Alignment.center,
      children: children,
    );
  }
}

class _Glass extends StatelessWidget {
  final double fadeIn;
  _Glass({Key key, this.fadeIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // prevents clicks through it to layer under
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {},
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(
          sigmaX: fadeIn * 8,
          sigmaY: fadeIn * 8,
        ),
        child: Container(
          color: Theme.of(context)
              .colorScheme
              .background
              .withOpacity(fadeIn * 0.60),
        ),
      ),
    );
  }
}
