import 'package:flutter/material.dart';
import 'package:wan_android_demo/common/localization/WALocalizations.dart';
import 'package:wan_android_demo/common/localization/language/base/WAStringBase.dart';

class Language{

  static WAStringBase getString(BuildContext context) {
    var wALocalizations = WALocalizations.of(context);
    return wALocalizations.currentLocalized;
  }
}