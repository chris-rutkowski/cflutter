import 'package:flutter/material.dart';

import '../../../utils/enums.dart';
import '../loading_view.dart';
import '../no_internet.dart';
import '../technical_error.dart';
import 'fragment_keys.dart' as K;

class Fragment extends StatelessWidget {
  final ViewType viewType;
  final Widget Function(BuildContext) builder;

  Fragment({Key? key, required this.viewType, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (viewType == ViewType.offline) {
      return NoInternet(key: Key(K.noInternet));
    } else if (viewType == ViewType.error) {
      return TechnicalError(key: Key(K.technicalError));
    } else if (viewType == ViewType.loading) {
      return LoadingView(key: Key(K.loadingView));
    } else {
      return Builder(builder: builder);
    }
  }
}
