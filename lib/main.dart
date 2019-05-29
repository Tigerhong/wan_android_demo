import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wan_android_demo/common/localization/WALocalizationsDelegate.dart';
import 'package:wan_android_demo/state/provide/OpenDrawerWidget.dart';
import 'package:wan_android_demo/state/provide/RefreshWidget.dart';
import 'package:wan_android_demo/state/scoped/ThemeModel.dart';
import 'package:wan_android_demo/ui/page/wecome/WeclcomePage.dart';
import 'package:wan_android_demo/utils/Log.dart';

void main() {
  ///强制应用竖屏
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MultiProvider(
    providers: [
      ListenableProvider<RefreshWidget>.value(listenable: RefreshWidget()),
      ListenableProvider<OpenDrawerhWidget>.value(
          listenable: OpenDrawerhWidget()),
    ],
    child: WanAndroidApp(),
  ));
}

class WanAndroidApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ThemeModel>(
        model: ThemeModel(),
        child: ScopedModelDescendant<ThemeModel>(
          builder: (context, child, model) => MaterialApp(
                  localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    WALocalizationsDelegate.delegate,
                  ],
                  supportedLocales: [
                     Locale('en', ''),
                     Locale('zh', ''),
                  ],
                  locale: model.locale,
                  title: "WanAndroid",
                  theme: ThemeData(primaryColor: model.getColor()),
                  home: GSYLocalizations(child: WeclcomePage())),
        ));
  }
}

class GSYLocalizations extends StatefulWidget {
  final Widget child;

  GSYLocalizations({Key key, this.child}) : super(key: key);

  @override
  State<GSYLocalizations> createState() {
    return new _GSYLocalizations();
  }
}

class _GSYLocalizations extends State<GSYLocalizations> {
  @override
  Widget build(BuildContext context) {
    //Localizations 提供一个 override 方法构建 Localizations ，这个方法中可以设置 locale
    // ，而我们需要的正是实时的动态切换语言显示
    return Localizations.override(
      context: context,
      locale: ThemeModel.of(context).locale,
      child: widget.child,
    );
  }
}
