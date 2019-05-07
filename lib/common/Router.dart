import 'package:flutter/material.dart';
import 'package:wan_android_demo/ui/web/WebViewPage.dart';

class Router{
  static void openWeb(BuildContext context, String url, String title){
    Navigator.push(context, new MaterialPageRoute(builder: (context) {
      return WebViewPage(url: url,title: title,);
    }));
  }
}