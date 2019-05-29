import 'package:flutter/material.dart';
import 'package:wan_android_demo/common/localization/language/EnString.dart';
import 'package:wan_android_demo/common/localization/language/base/WAStringBase.dart';
import 'package:wan_android_demo/common/localization/language/ZhString.dart';
import 'package:wan_android_demo/utils/Log.dart';

class WALocalizations {
  static String TAG = 'WALocalizations';
  final Locale locale;

  WALocalizations(this.locale);

  ///根据不同 locale.languageCode 加载不同语言对应
  ///GSYStringEn和GSYStringZh都继承了GSYStringBase
  static Map<String, WAStringBase> _localizedValues = {
    'en': new EnString(),
    'zh': new ZhString(),
  };

  WAStringBase get currentLocalized {
    Log.logT(TAG, "currentLocalized $locale");
    return _localizedValues[locale.languageCode];
  }
  static WALocalizations get(BuildContext context) {
    var of = Localizations.of(context, WALocalizations);
    Log.logT(TAG, "of  ${of.toString()}");
    return of;
  }
  ///通过 Localizations 加载当前的 WALocalizations
  ///获取对应的 WAStringBase
  static WALocalizations of(BuildContext context) {
    var of = Localizations.of(context, WALocalizations);
    Log.logT(TAG, "of  ${of.toString()}");
    return of;
  }
}




