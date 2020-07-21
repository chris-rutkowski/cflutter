import 'package:flutter/material.dart';

import '../../utils/theme/space.dart';
import '../custom_divider.dart';
import '../platform_ink_well.dart';
import 'cell_keys.dart';

abstract class Accessory {}

class ChevronAccessory implements Accessory {}

class RadioAccessory implements Accessory {
  final bool checked;
  RadioAccessory({this.checked = false});
}

class CheckboxAccessory implements Accessory {
  final bool checked;
  CheckboxAccessory({this.checked = false});
}

class ImageAccessory implements Accessory {
  final ImageProvider imageProvider;
  ImageAccessory(this.imageProvider);
}

class Cell extends StatelessWidget {
  static var headerToBodyMargin = small;

  final String header;
  final String body;
  final int bodyMaxLines;
  final Accessory accessory;
  final String error;
  final GestureTapCallback onTap;

  Cell({
    Key key,
    this.header,
    this.body,
    this.bodyMaxLines,
    this.accessory,
    this.error,
    this.onTap,
  }) : super(key: key);

  Widget _buildAccessory(BuildContext context) {
    if (accessory is ChevronAccessory) {
      return Icon(
        Icons.chevron_right,
        size: 28,
      );
    } else if (accessory is ImageAccessory) {
      return Image(image: (accessory as ImageAccessory).imageProvider);
    } else if (accessory is RadioAccessory) {
      final radioAccessory = accessory as RadioAccessory;
      return Stack(
        children: <Widget>[
          Container(
            width: 18,
            height: 18,
            child: Radio(
              groupValue: true,
              value: radioAccessory.checked,
              onChanged: (_) {
                if (onTap == null) return;
                onTap();
              },
            ),
          ),
          // hidden text widget for UI Tests
          Container(
            width: 0,
            height: 0,
            child: Text(
              radioAccessory.checked.toString(),
              key: Key(CellKeys.radioInfo),
            ),
          ),
        ],
      );
    } else if (accessory is CheckboxAccessory) {
      final checkboxAccessory = accessory as CheckboxAccessory;
      return Stack(
        children: <Widget>[
          Container(
            width: 18,
            height: 18,
            child: Checkbox(
              value: checkboxAccessory.checked,
              onChanged: (_) {
                if (onTap == null) return;
                onTap();
              },
            ),
          ),
          // hidden text widget for UI Tests
          Container(
            width: 0,
            height: 0,
            child: Text(
              checkboxAccessory.checked.toString(),
              key: Key(CellKeys.checkboxInfo),
            ),
          ),
        ],
      );
    }

    assert(accessory == null);
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformInkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
          left: small,
          right: small,
          top: medium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text(
                    header,
                    key: Key(CellKeys.header),
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                _buildAccessory(context),
              ],
            ),
            ...bodyWidgets(context),
            SizedBox(height: small),
            CustomDivider(error: error != null),
            Visibility(
              visible: error != null,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: xSmall),
                child: Text(
                  error ?? '',
                  key: Key(CellKeys.error),
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: Theme.of(context).colorScheme.error),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> bodyWidgets(BuildContext context) {
    if (body == null) {
      return [];
    }

    return [
      SizedBox(height: headerToBodyMargin),
      Text(
        body,
        maxLines: bodyMaxLines,
        overflow: bodyMaxLines != null
            ? TextOverflow.ellipsis
            : DefaultTextStyle.of(context).overflow,
        key: Key(CellKeys.body),
        style: Theme.of(context).textTheme.bodyText1,
      ),
    ];
  }
}
