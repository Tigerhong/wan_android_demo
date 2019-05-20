import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provide/provide.dart';
import 'package:wan_android_demo/ui/page/App.dart';
import 'package:wan_android_demo/ui/page/RefreshWidget.dart';

void main(){
  ///强制应用竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  var providers = Providers()..provide(Provider.function((ctx) => RefreshWidget()));
  runApp(
      ProviderNode(
        providers: providers,
        child: App()),
      );
}

