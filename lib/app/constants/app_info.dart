import 'package:package_info_plus/package_info_plus.dart';

class App {
  static late final PackageInfo packageInfo;

  App._();

  App.init(PackageInfo packageInfo) {
    App.packageInfo = packageInfo;
  }
}
