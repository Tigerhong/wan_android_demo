import 'package:flutter/material.dart';

class GlobalConfig {
  ///颜色
  static Color colorPrimary = Colors.red;
  static Color color_tags = Color(0xFF009a61);
  static Color color_black = Color(0xFF000000);
  static Color color_dark_gray = Color(0xFF6b6b6b);
  static Color color_white_a80 = Color(0xccffffff);



  static List<Color> getThemeListColor() {
    return [
      GlobalConfig.colorPrimary,
      Colors.brown,
      Colors.blue,
      Colors.teal,
      Colors.amber,
      Colors.blueGrey,
      Colors.deepOrange,
    ];
  }

  static List<String> getThemeListTitle = [
    "默认",
    "主题1",
    "主题2",
    "主题3",
    "主题4",
    "主题6",
    "主题7",
  ];
  static List<String> getLanguageListTitle = [
    "默认",
    "中文",
    "english",
  ];

  static Locale getLocale(int index){
    Locale locale;
    switch (index) {
      case 0:
//        locale = Locale('', '');
        break;
      case 1:
        locale = Locale('zh', 'CH');
        break;
      case 2:
        locale = Locale('en', 'US');
        break;
    }
    return locale;
  }
}
