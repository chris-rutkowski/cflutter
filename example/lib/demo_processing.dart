import 'package:cflutter/domain/providers/processing.dart';
import 'package:cflutter/presentation/widgets/cell/cell.dart';
import 'package:flutter/material.dart';

class DemoProcessing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo processing'),
      ),
      body: ListView(
        children: [
          Cell(
            header: 'Start and cancel (2s)',
            onTap: () async {
              Processing.of(context).start('hey');
              await Future.delayed(Duration(seconds: 2));
              Processing.of(context).cancel();
            },
          ),
          Cell(
            header: 'Start and complete',
            onTap: () async {
              Processing.of(context).start('hey');
              await Future.delayed(Duration(seconds: 2));
              Processing.of(context).complete('Completed');
            },
          ),
          Cell(
            header: 'Start and complete (custom icon)',
            onTap: () async {
              Processing.of(context).start('hey');
              await Future.delayed(Duration(seconds: 2));
              Processing.of(context).complete('Mail', icon: Icons.contact_mail);
            },
          ),
          Cell(
            header: 'Start and complete (custom child)',
            onTap: () async {
              Processing.of(context).start('hey');
              await Future.delayed(Duration(seconds: 2));
              Processing.of(context).complete('Custom child',
                  child: Text(
                    'wow',
                    style: Theme.of(context).textTheme.bodyText1,
                  ));
            },
          )
        ],
      ),
    );
  }
}
