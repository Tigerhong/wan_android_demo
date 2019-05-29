import 'package:flutter/material.dart';
import 'package:wan_android_demo/utils/Log.dart';

class OpenDrawerhWidget extends ChangeNotifier {
  void refresh() {
    Log.logT("OpenDrawerhWidget", "refresh()");
    notifyListeners(); //父类的方法,发出通知
  }
}
