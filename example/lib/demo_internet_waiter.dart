import 'package:cflutter/data/internet_waiter.dart';
import 'package:cflutter/presentation/widgets/cell/cell.dart';
import 'package:cflutter/presentation/widgets/screen_scaffold/screen_scaffold.dart';
import 'package:flutter/material.dart';

class DemoInternetWaiter extends StatefulWidget {
  @override
  _DemoInternetWaiterState createState() => _DemoInternetWaiterState();
}

class _DemoInternetWaiterState extends State<DemoInternetWaiter> {
  String checkNowResult = 'n/a';

  final waiter = InternetWaiterImpl(
    seemsOnlineRefreshDuration: Duration(seconds: 10),
    fallbackUrl: 'https://google.com',
  );

  @override
  void initState() {
    super.initState();
    _autoRefresh();
  }

  void _autoRefresh() async {
    setState(() {});
    await Future.delayed(Duration(seconds: 1));
    if (mounted) _autoRefresh();
  }

  @override
  void dispose() {
    waiter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      appBarTitle: 'Demo internet waiter',
      children: (context) => [
        Cell(
          header: 'Check now',
          body: 'Result: $checkNowResult',
          onTap: () async {
            setState(() => checkNowResult = 'checking');
            final online = await waiter.isOnline;
            if (!mounted) return;
            if (online) {
              setState(() => checkNowResult = 'online');
            } else {
              setState(() => checkNowResult = 'offline');
              await waiter.wait();
              if (!mounted) return;
              setState(() => checkNowResult = 'online');
            }
          },
        ),
        Cell(
          header: 'Seems online',
          body: '${waiter.seemsOnline}',
        )
      ],
    );
  }
}
