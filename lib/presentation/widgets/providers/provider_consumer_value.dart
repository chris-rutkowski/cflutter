import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderConsumerValue<T extends ChangeNotifier> extends StatelessWidget {
  final T value;
  final Widget Function(BuildContext context, T value, Widget child) builder;

  ProviderConsumerValue({Key key, this.value, this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value: value, child: Consumer<T>(builder: builder));
  }
}
