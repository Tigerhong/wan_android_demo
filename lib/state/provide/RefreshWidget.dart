import 'package:flutter/material.dart';
import 'package:wan_android_demo/utils/Log.dart';

class RefreshWidget with ChangeNotifier {
  RefreshWidget();
  void refresh() {
    Log.logT("RefreshWidget", "refresh()");
    notifyListeners(); //父类的方法,发出通知
  }
}
