import 'package:flutter/material.dart';

import '../../utils/theme/space.dart';
import '../custom_divider.dart';
import 'text_field_cell_keys.dart';

class TextFieldCell extends StatefulWidget {
  final String header;
  final String information;
  final String hint;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final int maxLength;
  final bool maxLengthEnforced;
  final String error;
  final String value;
  final Widget prefix;
  final Widget suffix;
  final ValueChanged<String> onChanged;
  final TextEditingController textEditingController;
  final bool autofocus;
  final int maxLines;
  final bool displayCharacterCounter;
  final bool obscureText;
  final ValueChanged<String> onSubmitted;
  final bool autocorrect;
  final TextInputAction textInputAction;

  TextFieldCell({
    Key key,
    this.header,
    this.information,
    this.hint,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType,
    this.maxLength,
    this.maxLengthEnforced = false,
    this.error,
    this.onChanged,
    this.value,
    this.prefix,
    this.suffix,
    this.textEditingController,
    this.autofocus = false,
    this.maxLines = 1,
    this.displayCharacterCounter = false,
    this.obscureText = false,
    this.onSubmitted,
    this.autocorrect = true,
    this.textInputAction,
  }) : super(key: key);

  @override
  _TextFieldCellState createState() => _TextFieldCellState();
}

class _TextFieldCellState extends State<TextFieldCell> {
  final focusNode = FocusNode();
  TextEditingController controller;
  bool _ownController = false;

  @override
  void initState() {
    super.initState();

    if (widget.textEditingController != null) {
      controller = widget.textEditingController;
    } else {
      controller = TextEditingController();
      _ownController = true;
    }

    if (widget.value != null) controller.text = widget.value;

    controller.addListener(() {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        if (widget.onChanged != null) {
          widget.onChanged(controller.text);
        }
      }

      setState(() {}); // refreshes underline color
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    if (_ownController) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];

    if (widget.header != null) {
      children.add(
        Text(
          widget.header,
          key: Key(TextFieldCellKeys.header),
          style: Theme.of(context).textTheme.headline3,
        ),
      );
      children.add(SizedBox(height: xSmall));
    }

    if (widget.information != null) {
      children.add(
        Text(
          widget.information,
          key: Key(TextFieldCellKeys.information),
          style: Theme.of(context).textTheme.bodyText1,
        ),
      );
      children.add(SizedBox(height: small));
    }

    children.add(SizedBox(height: xSmall));

    final textField = TextField(
      autofocus: widget.autofocus,
      key: Key(TextFieldCellKeys.textField),
      focusNode: focusNode,
      controller: controller,
      textCapitalization: widget.textCapitalization,
      keyboardType: widget.keyboardType,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(color: Theme.of(context).hintColor),
        counter: Offstage(),
        contentPadding: EdgeInsets.zero,
        isDense: true,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
      cursorColor: Theme.of(context).colorScheme.primary,
      maxLength: widget.maxLength,
      maxLengthEnforced: widget.maxLengthEnforced,
      onChanged: widget.onChanged,
      maxLines: widget.maxLines,
      obscureText: widget.obscureText,
      onSubmitted: widget.onSubmitted,
      autocorrect: widget.autocorrect,
      textInputAction: widget.textInputAction,
    );

    children.addAll([
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.prefix ?? Container(),
          Expanded(child: textField),
          widget.suffix ?? Container(),
        ],
      ),
      SizedBox(height: 2),
      CustomDivider(error: widget.error != null, focus: focusNode.hasFocus),
    ]);

    if (widget.error != null || widget.displayCharacterCounter) {
      Widget errorText;
      Widget characterCounter;

      if (widget.error != null) {
        errorText = Text(
          widget.error,
          key: Key(TextFieldCellKeys.errorMessage),
          style: Theme.of(context)
              .textTheme
              .caption
              .copyWith(color: Theme.of(context).colorScheme.error),
        );
      } else {
        errorText = Container();
      }

      if (widget.displayCharacterCounter) {
        characterCounter = Padding(
          padding: const EdgeInsets.only(left: xxSmall),
          child: Text(
            '${controller.text.length}/${widget.maxLength}',
            key: Key(TextFieldCellKeys.characterCounter),
            style: Theme.of(context).textTheme.caption,
          ),
        );
      } else {
        characterCounter = Container();
      }

      children.addAll([
        SizedBox(height: xSmall),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: errorText,
            ),
            characterCounter,
          ],
        ),
        SizedBox(height: xSmall),
      ]);
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(focusNode);
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: widget.header != null ? medium : small,
          bottom: 0,
          right: small,
          left: small,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(TextFieldCell oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value) {
      controller.value = TextEditingValue(
        text: widget.value,
        selection: controller.selection,
      );
    }
  }
}
