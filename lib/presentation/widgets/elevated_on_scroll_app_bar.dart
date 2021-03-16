import 'package:flutter/material.dart';

class ElevatedOnScrollAppBar extends StatefulWidget implements PreferredSizeWidget {
  final ScrollController? scrollController;
  final bool? centerTitle;
  final bool automaticallyImplyLeading;
  final double minOffsetForElevation;
  final Widget? leading;
  final Widget? title;
  final double titleSpacing;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));

  ElevatedOnScrollAppBar({
    Key? key,
    this.scrollController,
    this.centerTitle,
    this.automaticallyImplyLeading = true,
    this.minOffsetForElevation = 1,
    this.leading,
    this.title,
    this.titleSpacing = 0,
    this.actions,
    this.bottom,
  }) : super(key: key);

  @override
  _ElevatedOnScrollAppBarState createState() => _ElevatedOnScrollAppBarState();
}

class _ElevatedOnScrollAppBarState extends State<ElevatedOnScrollAppBar> {
  bool _isElevated = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController?.addListener(updateIsElevated);
  }

  void updateIsElevated() {
    if (widget.scrollController == null || !widget.scrollController!.hasClients) {
      return;
    }

    final offset = widget.scrollController!.offset;
    if (offset >= widget.minOffsetForElevation && !_isElevated) {
      setState(() => _isElevated = true);
    } else if (offset < widget.minOffsetForElevation && _isElevated) {
      setState(() => _isElevated = false);
    }
  }

  Widget _appBar(BuildContext context) {
    return AppBar(
      elevation: _isElevated ? Theme.of(context).appBarTheme.elevation : 0,
      centerTitle: widget.centerTitle,
      automaticallyImplyLeading: widget.automaticallyImplyLeading,
      leading: widget.leading,
      title: widget.title,
      titleSpacing: widget.titleSpacing,
      actions: widget.actions,
      bottom: widget.bottom,
    );
  }

  @override
  Widget build(BuildContext context) => _appBar(context);
}
