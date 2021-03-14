import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/theme/space.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  static Widget Function(BuildContext context)? builder;

  LoadingIndicator({Key? key, this.size = 96}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return builder != null
        ? builder!(context)
        : SpinKitRing(
            color: Theme.of(context).colorScheme.primary,
            size: size,
            lineWidth: xSmall * size / 96,
          );
  }
}
