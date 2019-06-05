import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:wan_android_demo/common/Router.dart';
import 'package:wan_android_demo/common/User.dart';
import 'package:wan_android_demo/common/localization/Language.dart';
import 'package:wan_android_demo/ui/dialog/LanguageDialog.dart';
import 'package:wan_android_demo/ui/dialog/LogoutConfirmDialog.dart';
import 'package:wan_android_demo/ui/dialog/ThemeSelectDialog.dart';
import 'package:wan_android_demo/state/scoped/ThemeModel.dart';
import 'package:wan_android_demo/utils/Log.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppDrawer();
}

class _AppDrawer extends State {
  @override
  Widget build(BuildContext context) {
    Widget userHeader = UserAccountsDrawerHeader(
      accountName: Text("${User().isLogin() ? User().userName : "----"}"),
      accountEmail: new Text(
          "${User().isLogin() ? User().email.isEmpty ? "${User().userName}@163.com" : "" : "----"}"),
      currentAccountPicture: new CircleAvatar(
        backgroundImage: NetworkImage(
            'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3661190565,2567921435&fm=26&gp=0.jpg'),
        radius: 35.0,
      ),
    );
    var itemColor = ThemeModel.of(context).getColor();

    return Drawer(
        child: Container(
            child: Column(
      children: <Widget>[
        userHeader, // 可在这里替换自定义的header
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                  title: Text(Language.getString(context).article_collect()),
                  leading: new CircleAvatar(
                    backgroundColor: itemColor,
                    child: new Icon(Icons.favorite),
                  ),
                  onTap: () {
                    if (User().isLogin()) {
                      Router.openArticleCollectPage(context);
                    } else {
                      Toast.show(
                          Language.getString(context).no_login(), context,
                          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                    }
                  }),
              ListTile(
                title: Text(Language.getString(context).switch_theme()),
                leading: new CircleAvatar(
                  backgroundColor: itemColor,
                  child: new Icon(Icons.color_lens),
                ),
                onTap: () {
                  ThemeSelectDialog.show(context);
                },
              ),
              ListTile(
                title: Text(Language.getString(context).switch_language()),
                leading: new CircleAvatar(
                  backgroundColor: itemColor,
                  child: new Icon(Icons.language),
                ),
                onTap: () {
                  LanguageDialog.show(context);
                },
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          width: double.infinity,
          child: RaisedButton(
            color: Colors.yellow,
            textColor: Colors.white,
            onPressed: () {
              if (User().isLogin()) {
                LogoutConfirmDialog.showLogoutConfirmDialog(context, () {
                  setState(() {});
                });
              } else {
                openLoginRegister(context);
              }
            },
            child: Text(
                "${User().isLogin() ? Language.getString(context).logout() : Language.getString(context).login()}"),
          ),
        )
      ],
    )));
  }

  void openLoginRegister(BuildContext context) async {
    Map openLoginRegister = await Router.openLoginRegister(context);
//    if (openLoginRegister ?? true) return;
//    bool isReload = openLoginRegister["isReload"];
//    Log.logT("MimePage", "openLoginRegister $isReload");
//    if (isReload) {
//      globalKey.currentState.reLoadData();
//    }
  }
}
