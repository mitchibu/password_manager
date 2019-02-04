import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:package_info/package_info.dart';
import 'package:password_manager/statefulmodel.dart';
import 'package:uni_links/uni_links.dart';

import 'model.dart';
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
      uri: await getInitialLink(),
      packageInfo: await PackageInfo.fromPlatform(),
    );
  }

  Widget _build_bk(BuildContext context, AppModel model) => DynamicTheme(
    defaultBrightness: Brightness.light,
    data: (brightness) {
      return new ThemeData(
          brightness: brightness,
          primaryColor: Colors.white,
          accentColor: Colors.red,
          fontFamily: "HigashiOme");
    },
    themedWidgetBuilder: (context, theme) => MaterialApp(
      title: model.packageInfo.appName,
      theme: ThemeData.dark(),
      home: HomePage(),
    ),
  );

  Widget _build(BuildContext context, AppModel model) => MaterialApp(
    title: model.packageInfo.appName,
    theme: ThemeData.dark(),
    home: HomePage(),
  );
}
