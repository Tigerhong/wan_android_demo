
import 'package:flutter/material.dart';
import 'package:wan_android_demo/common/GlobalConfig.dart';
import 'package:wan_android_demo/common/User.dart';

class LogoutConfirmDialog{

  ///显示确认退出对话框
 static Future<Null> showLogoutConfirmDialog(BuildContext context,VoidCallback okCallback) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return _buildLogoutConfirmDialog(context,okCallback);
        });
  }

  static Widget _buildLogoutConfirmDialog(BuildContext context,VoidCallback okCallback) {
    return AlertDialog(
      content: Text("确定退出登录？"),
      actions: <Widget>[
        RaisedButton(
          elevation: 0.0,
          child: Text("OK"),
          color: Colors.transparent,
          textColor: GlobalConfig.colorPrimary,
          onPressed: () {
            User().logout();
            User().refreshUserData(callback: () {
              okCallback();
            });
            Navigator.pop(context);
          },
        ),
        RaisedButton(
          elevation: 0.0,
          color: Colors.transparent,
          textColor: GlobalConfig.colorPrimary,
          child: Text("No No No"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}