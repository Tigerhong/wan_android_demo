import 'package:flutter/material.dart';
import 'package:wan_android_demo/common/GlobalConfig.dart';
import 'package:wan_android_demo/common/Sp.dart';
import 'package:wan_android_demo/state/scoped/ThemeModel.dart';
import 'package:wan_android_demo/ui/dialog/CommonDialog.dart';
import 'package:wan_android_demo/utils/Log.dart';

class LanguageDialog {
  static void show(BuildContext context) async {
    var languageIndex = await Sp.getSAsync(SpConsKy.key_language);
    CommonDialog.show(context, GlobalConfig.getLanguageListTitle, (index) {
      Locale locale = GlobalConfig.getLocale(index);
      Log.logT("LanguageDialog",
          "show index:::$index  locale:::${locale?.toString()}");
      ThemeModel.of(context).setLocale(locale);
      Sp.put(SpConsKy.key_language, "$index");
      Navigator.of(context).pop();
    }, selectIndex: int.parse(languageIndex ?? "0"));
  }
}
