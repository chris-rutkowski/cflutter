import 'package:flutter/material.dart';

import '../platform_flat_button.dart';
import 'unsaved_changes_alert_keys.dart';

class UnsavedChangesAlert extends StatelessWidget {
  static var title = 'Want to discard your changes?';
  static var subtitle = 'You will lose your changes if you continue without saving them.';
  static var confirm = 'Discard';
  static var cancel = 'Cancel';

  static Future<bool> ask(BuildContext context) async {
    return (await showDialog<bool>(
          context: context,
          builder: (_) => UnsavedChangesAlert(),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: Key(UnsavedChangesAlertKeys.screen),
      title: Text(title, style: Theme.of(context).textTheme.headline3),
      content: Text(subtitle, style: Theme.of(context).textTheme.bodyText1),
      actions: <Widget>[
        // Cancel - user doesn't want to quit
        PlatformFlatButton(
          key: Key(UnsavedChangesAlertKeys.cancelButton),
          text: cancel,
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        // Confirm - yes user wants to lose unsaved changes
        PlatformFlatButton(
          key: Key(UnsavedChangesAlertKeys.confirmButton),
          text: confirm,
          textColor: Theme.of(context).colorScheme.error,
          onPressed: () {
            Navigator.pop(context, true);
          },
        )
      ],
    );
  }
}
