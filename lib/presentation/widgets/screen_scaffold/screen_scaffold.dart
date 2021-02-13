import 'package:flutter/material.dart';

import '../../../domain/analytics/appearance.dart';
import '../../../utils/enums.dart';
import '../../utils/theme/space.dart';
import '../appearance_notifier.dart';
import '../dismiss_button.dart';
import '../elevated_on_scroll_app_bar.dart';
import '../loading_view.dart';
import '../no_internet.dart';
import '../technical_error.dart';
import '../unsaved_changes_alert/unsaved_changes_alert.dart';
import 'screen_scaffold_keys.dart' as K;

class ScreenScaffold extends StatelessWidget {
  final Widget customAppBar;
  final ScrollController scrollController;
  final Function(Appearance) onAppearanceChanged;
  final List<Widget> Function(BuildContext) children;
  final Widget Function(BuildContext) body;
  final ExitType exitType;
  final ViewType viewType;
  final String appBarTitle;
  final Widget appBarTitleWidget;
  final VoidCallback appBarOnDismiss;
  final double appBarElevationOffset;
  final bool appBarCenterTitle;
  final List<Widget> appBarActions;
  final PreferredSizeWidget appBarBottom;
  final Color backgroundColor;

  ScreenScaffold({
    Key key,
    this.customAppBar,
    this.scrollController,
    this.onAppearanceChanged,
    this.children,
    this.body,
    this.exitType = ExitType.arrow,
    this.viewType,
    this.appBarTitle,
    this.appBarTitleWidget,
    this.appBarOnDismiss,
    this.appBarElevationOffset = medium,
    this.appBarCenterTitle,
    this.appBarActions,
    this.appBarBottom,
    this.backgroundColor,
  }) : super(key: key);

  PreferredSizeWidget _appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: Builder(
        builder: (context) => ElevatedOnScrollAppBar(
          centerTitle: appBarCenterTitle,
          automaticallyImplyLeading: exitType != ExitType.hidden,
          leading: [ExitType.hidden, ExitType.disabled].contains(exitType)
              ? null
              : DismissButton(
                  key: Key(K.dismissButton),
                  exitType: exitType,
                  onDismiss: appBarOnDismiss,
                ),
          titleSpacing: exitType == ExitType.hidden ? NavigationToolbar.kMiddleSpacing : 0,
          scrollController: scrollController ?? PrimaryScrollController.of(context),
          minOffsetForElevation: appBarElevationOffset,
          title: appBarTitleWidget ?? Text(appBarTitle),
          actions: appBarActions,
          bottom: appBarBottom,
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    if (viewType == ViewType.offline) {
      return NoInternet(key: Key(K.noInternet));
    } else if (viewType == ViewType.error) {
      return TechnicalError(key: Key(K.technicalError));
    } else if (viewType == ViewType.loading) {
      return LoadingView(key: Key(K.loadingView));
    } else {
      return Builder(
        builder: (context) => body != null
            ? body(context)
            : ListView(
                key: Key(K.list),
                controller: scrollController ?? PrimaryScrollController.of(context),
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: medium),
                children: children(context),
              ),
      );
    }
  }

  Widget _onPopScope(BuildContext context) {
    if ([ExitType.arrow, ExitType.hidden].contains(exitType)) {
      return Container();
    } else {
      return WillPopScope(
        onWillPop: () async {
          FocusScope.of(context).unfocus();

          if (exitType == ExitType.warning) {
            return await UnsavedChangesAlert.ask(context);
          } else if (exitType == ExitType.x) {
            return true;
          } else {
            return false;
          }
        },
        child: Container(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: customAppBar == null ? _appBar(context) : null,
      body: AppearanceNotifier(
        onAppearanceChanged:
            onAppearanceChanged != null ? (v) => onAppearanceChanged(v ? Appearance.visit : Appearance.leave) : null,
        child: Column(
          children: [
            customAppBar ?? Container(),
            Expanded(
              child: Stack(
                children: <Widget>[
                  _body(context),
                  _onPopScope(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
