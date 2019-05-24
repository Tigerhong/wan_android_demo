import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wan_android_demo/common/GlobalConfig.dart';
import 'package:wan_android_demo/common/Router.dart';
import 'package:wan_android_demo/common/Snack.dart';
import 'package:wan_android_demo/common/User.dart';
import 'package:wan_android_demo/common/localization/Language.dart';
import 'package:wan_android_demo/state/scoped/ThemeModel.dart';
import 'package:wan_android_demo/utils/Log.dart';

class LoginRegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginRegisterPage> {
  TextEditingController accountTEC;
  TextEditingController passwordTEC;
  bool isShowLogin = true;

  @override
  void initState() {
    super.initState();
    accountTEC = new TextEditingController();
    passwordTEC = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(isShowLogin ?Language.getString(context).login_title() :Language.getString(context).login_title_regise()),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: accountTEC,
              keyboardType: TextInputType.emailAddress, //输入的类型
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  labelText:Language.getString(context).login_user_name(),
                  hintText:Language.getString(context).login_user_name_hint()),
              autofocus: false,
            ),
            TextField(
                controller: passwordTEC,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText:Language.getString(context).login_user_password(),
                    hintText:Language.getString(context).login_user_password_hint()),
                autofocus: false,
                obscureText: true),
            buildLoginLogoutBt(context),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: FlatButton(
                    onPressed: () {
                      isShowLogin = !isShowLogin;
                      setState(() {});
                    },
                    child: Text(isShowLogin ? Language.getString(context).login_text_regiser() :  Language.getString(context).login_text_login())),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildLoginLogoutBt(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.only(top: 10),
          width: double.infinity,
          child: RaisedButton(
              padding: const EdgeInsets.all(8.0),
              color: GlobalConfig.colorPrimary,
              textColor: Colors.white,
              elevation: 4.0,
              child: Text(isShowLogin ?Language.getString(context).login_title() :Language.getString(context).login_title_regise()),

              ///需要设置onPressed，color，textColor才能使用
              onPressed: () {
                _login(context);
              }),
        );
      },
    );
  }

  ///登录
  void _login([BuildContext context]) {
    if (accountTEC.text.length == 0) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text(Language.getString(context).login_no_user_name()),
              ));
      return;
    } else if (passwordTEC.text.length == 0) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text(Language.getString(context).login_no_password()),
              ));
      return;
    }
    Log.logT("_login", "account:${accountTEC.text} pwd:${passwordTEC.text}");
    var callback = (bool loginOK, String errorMsg) {
      if (loginOK) {
        Snack.show(context, Language.getString(context).login_success());
        //snack中的context需要使用Scaffold里面的，
        Timer(Duration(milliseconds: 400), () {
          Router().back(context, args: {"isReload":true});
        });
      } else {
        Snack.show(context, errorMsg);
      }
    };
    var _userNameStr = accountTEC.text;
    var _psdStr = passwordTEC.text;
    User().userName = _userNameStr;
    User().password = _psdStr;
    isShowLogin
        ? User().login(callback: callback)
        : User().register(callback: callback);
  }
}
