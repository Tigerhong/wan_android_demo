import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wan_android_demo/common/GlobalConfig.dart';
import 'package:wan_android_demo/common/localization/WALocalizations.dart';
import 'package:wan_android_demo/common/localization/language/base/WAStringBase.dart';
import 'package:wan_android_demo/utils/Log.dart';

class ThemeModel extends Model {
  String TAG="ThemeModel";
  /// Wraps [ScopedModel.of] for this [Model].
  static ThemeModel of(BuildContext context) =>
      ScopedModel.of<ThemeModel>(context);

  int _index = 0;

  int get index => _index;

  void setIndex(int index) {
    _index = index;
    notifyListeners();
  }

  Color getColor() {
    return GlobalConfig.getThemeListColor()[index];
  }

  Locale locale = Locale('en', 'US');

  void setLocale(Locale _locale) {
    locale = _locale;
    Log.logT(TAG, "setLocale  locale:::${locale}");
    notifyListeners();
  }


}
