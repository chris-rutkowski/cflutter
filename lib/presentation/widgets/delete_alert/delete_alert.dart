import 'package:flutter/material.dart';

import '../platform_flat_button.dart';
import 'delete_alert_keys.dart' as K;

class DeleteAlert extends StatelessWidget {
  final String title;
  final String body;
  final String deleteButton;
  final String cancelButton;

  DeleteAlert({
    Key? key,
    required this.title,
    required this.body,
    required this.deleteButton,
    required this.cancelButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: Key(K.screen),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline3,
      ),
      content: Text(
        body,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      actions: <Widget>[
        // Cancel - user doesn't want to delete
        PlatformFlatButton(
          key: Key(K.cancelButton),
          text: cancelButton,
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        // Confirm - user wants to delete
        PlatformFlatButton(
          key: Key(K.deleteButton),
          text: deleteButton,
          textColor: Theme.of(context).colorScheme.error,
          onPressed: () {
            Navigator.pop(context, true);
          },
        )
      ],
    );
  }
}
