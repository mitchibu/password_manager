import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:password_manager/statefulmodel.dart';

import 'model.dart';
import 'test.dart';
import 'ui/home/main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => FutureBuilder<AppModel>(
    future: _init(),
    builder: (context, snapshot) {
      if(snapshot.connectionState != ConnectionState.done) return Container();
      return StatefulModel<AppModel>.builder(
        creator: (context, model) => snapshot.data,
        builder: _build,
      );
    },
  );

  Future<AppModel> _init() async {
    return AppModel(
      intent: await Sample().getIntent(),
      packageInfo: await PackageInfo.fromPlatform(),
    );
  }

  Widget _build(BuildContext context, AppModel model) => MaterialApp(
    title: model.packageInfo.appName,
    theme: ThemeData.dark(),
    home: HomePage(),
  );
}
