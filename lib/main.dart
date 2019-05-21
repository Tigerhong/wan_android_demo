import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provide/provide.dart';
import 'package:wan_android_demo/ui/page/RefreshWidget.dart';
import 'package:wan_android_demo/ui/page/wecome/WeclcomePage.dart';

void main() {
  ///强制应用竖屏
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  var providers = Providers()
    ..provide(Provider.function((ctx) => RefreshWidget()));
  runApp(
    ProviderNode(providers: providers, child: WanAndroidApp()),
  );
}

class WanAndroidApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "WanAndroid",
      theme: ThemeData(primaryColor: Colors.red),
      home: WeclcomePage(),
    );
  }
}


