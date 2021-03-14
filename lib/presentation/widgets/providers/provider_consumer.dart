import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderConsumer<T extends ChangeNotifier> extends StatelessWidget {
  final Create<T> create;
  final Widget Function(BuildContext context, T value, Widget? child) builder;

  ProviderConsumer({Key? key, required this.create, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(create: create, child: Consumer<T>(builder: builder));
  }
}
