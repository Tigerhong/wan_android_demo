import 'package:flutter/material.dart';
import 'package:wan_android_demo/common/GlobalConfig.dart';
import 'package:wan_android_demo/common/Sp.dart';
import 'package:wan_android_demo/state/scoped/ThemeModel.dart';
import 'package:wan_android_demo/ui/dialog/CommonDialog.dart';
import 'package:wan_android_demo/utils/Log.dart';

class ThemeSelectDialog {
  static void show(BuildContext context) async {
    var themeIndex = await Sp.getSAsync(SpConsKy.key_theme);
    CommonDialog.show(context, GlobalConfig.getThemeListTitle, (index) {
      ThemeModel.of(context).setIndex(index);
      Log.logT("LanguageDialog", "show index:::$index }");
      Sp.put(SpConsKy.key_theme, "$index");
      Navigator.of(context).pop();
    },
        colors: GlobalConfig.getThemeListColor(),
        selectIndex: int.parse(themeIndex ?? "0"));
  }
}
