import 'package:package_info/package_info.dart';
import 'package:password_manager/statefulmodel.dart';

class AppModel extends Model {
  AppModel({this.uri, this.packageInfo}) {
    print('uri: $uri');
  }
  final String uri;
  final PackageInfo packageInfo;
}
