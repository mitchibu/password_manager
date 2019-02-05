import 'package:package_info/package_info.dart';
import 'package:password_manager/statefulmodel.dart';

import 'test.dart';

class AppModel extends Model {
  AppModel({this.intent, this.packageInfo}) {
    print('uri: $intent');
  }
  final Intent intent;
  final PackageInfo packageInfo;

  bool get isMushroom => intent.action == 'com.adamrocker.android.simeji.ACTION_INTERCEPT';
}
