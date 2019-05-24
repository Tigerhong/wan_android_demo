import 'package:flutter/material.dart';
import 'package:wan_android_demo/common/GlobalConfig.dart';
import 'package:wan_android_demo/common/Sp.dart';
import 'package:wan_android_demo/common/localization/Language.dart';
import 'package:wan_android_demo/ui/dialog/ThemeSelectDialog.dart';
import 'package:wan_android_demo/ui/page/App.dart';
import 'package:wan_android_demo/state/scoped/ThemeModel.dart';
import 'package:wan_android_demo/utils/Log.dart';

///欢迎界面
class WeclcomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => WeclcomeState();
}

class WeclcomeState extends State {
  String TAG="WeclcomePage";
  bool hadInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (hadInit) {
      return;
    }
    hadInit = true;
    _init();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (context) => DoubleClicBackConfirmPage()));
    });
  }

  _init() async {
    String themeIndex = await Sp.getSAsync(SpConsKy.key_theme);
    ThemeModel.of(context).setIndex(int.parse(themeIndex ?? "0"));

    String languageIndex = await Sp.getSAsync(SpConsKy.key_language);
    Log.logT(TAG, "languageIndex:::$languageIndex");
    ThemeModel.of(context)
        .setLocale(GlobalConfig.getLocale(int.parse(languageIndex ?? "0")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        color: Colors.blue,
        child: Center(
          child: Text(
            Language.getString(context).welcome_title(),
            style: TextStyle(color: Colors.white,fontSize: 20),
          ),
        ),
      ),
    );
  }
}

///点击返回按钮，确认退出界面
class DoubleClicBackConfirmPage extends StatelessWidget {
  /// 单击提示退出
  Future<bool> _dialogExitApp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
              content: new Text("是否退出"),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text("取消")),
                new FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: new Text("确定"))
              ],
            ));
  }

  ///使用WillPopScope时需要在外层使用MaterialApp后，里面的都不需要使用，
  ///否则会导致点击物理按键时，没有使界面栈pop，总是会弹出“是否退出确认框”，
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (Navigator.canPop(context)) {
          return Future.value(true);
        }

        ///如果返回 return new Future.value(false); popped 就不会被处理
        ///如果返回 return new Future.value(true); popped 就会触发
        ///这里可以通过 showDialog 弹出确定框，在返回时通过 Navigator.of(context).pop(true);决定是否退出
        return _dialogExitApp(context);
      },
      child: App(),
    );
  }
}
