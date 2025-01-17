import 'package:flutter/material.dart';

import '../../utils/theme/space.dart';
import '../custom_divider.dart';
import '../platform_ink_well.dart';
import 'cell_keys.dart';

abstract class Accessory {}

class ChevronAccessory implements Accessory {}

class XAccessory implements Accessory {}

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

  final header;
  final body;
  final int? bodyMaxLines;
  final Accessory? accessory;
  final String? error;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final bool showSeparator;

  Cell({
    Key? key,
    this.header,
    this.body,
    this.bodyMaxLines,
    this.accessory,
    this.error,
    this.onTap,
    this.onLongPress,
    this.showSeparator = true,
  }) : super(key: key);

  Widget _buildAccessory(BuildContext context) {
    if (accessory is ChevronAccessory) {
      return Icon(
        Icons.chevron_right,
        size: 28,
      );
    } else if (accessory is XAccessory) {
      return Icon(
        Icons.close,
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
              onChanged: onTap != null ? (_) => onTap!() : null,
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
              onChanged: onTap != null ? (_) => onTap!() : null,
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
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: PlatformInkWell(
        onTap: onTap,
        onLongPress: onLongPress,
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
                    child: _headerWidget(context),
                  ),
                  _buildAccessory(context),
                ],
              ),
              ...bodyWidgets(context),
              SizedBox(height: small),
              Visibility(
                visible: showSeparator,
                child: CustomDivider(error: error != null),
              ),
              Visibility(
                visible: error != null,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: xSmall),
                  child: Text(
                    error ?? '',
                    key: Key(CellKeys.error),
                    style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerWidget(BuildContext context) {
    if (header is String) {
      return Text(
        header as String,
        key: Key(CellKeys.header),
        style: Theme.of(context).textTheme.headline3,
      );
    } else if (header is Widget) {
      return header as Widget;
    } else {
      throw Exception('header can be either String or Widget');
    }
  }

  List<Widget> bodyWidgets(BuildContext context) {
    if (body == null) {
      return [];
    }

    final widgets = <Widget>[SizedBox(height: headerToBodyMargin)];

    if (body is String) {
      widgets.add(Text(
        body as String,
        maxLines: bodyMaxLines,
        overflow: bodyMaxLines != null ? TextOverflow.ellipsis : DefaultTextStyle.of(context).overflow,
        key: Key(CellKeys.body),
        style: Theme.of(context).textTheme.bodyText1,
      ));
    } else if (body is Widget) {
      widgets.add(body as Widget);
    } else {
      throw Exception('body can be either String or Widget');
    }

    return widgets;
  }
}
