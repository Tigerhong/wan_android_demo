import 'package:flutter/material.dart';
import 'package:wan_android_demo/ui/page/login/LoginRegisterPage.dart';
import 'package:wan_android_demo/ui/web/WebViewPage.dart';

class Router{

  static void openWeb(BuildContext context, String url, String title){
    Navigator.push(context, new MaterialPageRoute(builder: (context) {
      return WebViewPage(url: url,title: title,);
    }));
  }

  static openLoginRegister(BuildContext context){
    return Navigator.push(context, new MaterialPageRoute(builder: (context) {
      return LoginRegisterPage();
    }));
  }

  void back<T>(BuildContext context,{T args}) {
    Navigator.of(context).pop(args);
  }
}