import 'package:flutter/material.dart';

import '../../utils/enums.dart';
import '../utils/platform_icons.dart';
import 'platform_icon_button.dart';
import 'unsaved_changes_alert/unsaved_changes_alert.dart';

class DismissButton extends StatelessWidget {
  final ExitType exitType;
  final Function onDismiss;

  DismissButton({
    Key key,
    this.exitType,
    this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformIconButton(
      iconData: exitType == ExitType.warning
          ? Icons.close
          : exitType == ExitType.x
              ? Icons.close
              : PlatformIcons.arrowBack(context),
      onPressed: () async {
        FocusScope.of(context).unfocus();

        if (exitType == ExitType.warning) {
          if ((await UnsavedChangesAlert.ask(context)) ?? false) {
            _dismiss(context);
          }
        } else {
          _dismiss(context);
        }
      },
    );
  }

  void _dismiss(BuildContext context) =>
      onDismiss != null ? onDismiss() : Navigator.of(context).pop();
}
