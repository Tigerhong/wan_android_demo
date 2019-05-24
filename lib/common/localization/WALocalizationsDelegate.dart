import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wan_android_demo/common/localization/WALocalizations.dart';
import 'package:wan_android_demo/utils/Log.dart';

class WALocalizationsDelegate extends LocalizationsDelegate<WALocalizations> {
  String TAG="WALocalizationsDelegate";
  WALocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    var bool = ["en", "zh"].contains(locale.languageCode);
    Log.logT(TAG, "isSupported   ${locale.toString()}   isSupported:::$bool");
    return bool;
  }

  @override
  Future<WALocalizations> load(Locale locale) {
    Log.logT(TAG, "load  ${locale.toString()}");
    return SynchronousFuture<WALocalizations>(WALocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<WALocalizations> old) {
    Log.logT(TAG, "shouldReload ${old.toString()}");
    return true;
  }

  static WALocalizationsDelegate delegate = WALocalizationsDelegate();
}
