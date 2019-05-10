import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wan_android_demo/common/GlobalConfig.dart';
import 'package:wan_android_demo/common/Router.dart';
import 'package:wan_android_demo/common/Snack.dart';
import 'package:wan_android_demo/common/User.dart';
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
        title: Text(isShowLogin ? "登录" : "注册"),
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
                  labelText: "用户名",
                  hintText: "请输入用户名"),
              autofocus: false,
            ),
            TextField(
                controller: passwordTEC,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    labelText: "密码",
                    hintText: "请输入密码"),
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
                    child: Text(isShowLogin ? "注册新账号" : "直接登录")),
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
              child: Text(isShowLogin ? "登录" : "注册"),

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
                title: Text("用户名不能为空"),
              ));
      return;
    } else if (passwordTEC.text.length == 0) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text("密码不能为空"),
              ));
      return;
    }
    Log.logT("_login", "account:${accountTEC.text} pwd:${passwordTEC.text}");
    var callback = (bool loginOK, String errorMsg) {
      if (loginOK) {
        Snack.show(context, "登录成功");
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
