import 'package:flutter/material.dart';

import '../utils/theme/space.dart';

class TechnicalError extends StatelessWidget {
  static var title = 'Oops! Something went wrong.';
  static var subtitle = 'Our team is already working on it.\nPlease try again later.';
  TechnicalError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: small),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.warning,
                size: 96,
                color: Theme.of(context).colorScheme.error,
              ),
              SizedBox(height: medium),
              Text(
                title,
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: xSmall),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
