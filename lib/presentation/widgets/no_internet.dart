import 'package:flutter/material.dart';

import '../utils/theme/space.dart';

class NoInternet extends StatelessWidget {
  NoInternet({Key key}) : super(key: key);

  static var title = 'No Internet';
  static var subtitle =
      'Your device is not connected to the Internet. Please check your WiFi or mobile data connection.';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: small),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.cloud_off,
                size: 96,
                color: Theme.of(context).textTheme.headline3.color,
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
