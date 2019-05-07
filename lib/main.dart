import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wan_android_demo/ui/page/App.dart';

void main(){
  ///强制应用竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(App());
}

