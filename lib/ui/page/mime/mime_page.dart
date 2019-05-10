import 'package:flutter/material.dart';
import 'package:wan_android_demo/api/HttpService.dart';
import 'package:wan_android_demo/common/GlobalConfig.dart';
import 'package:wan_android_demo/common/Router.dart';
import 'package:wan_android_demo/common/User.dart';
import 'package:wan_android_demo/ui/page/article_list/ArticleListWidget.dart';
import 'package:wan_android_demo/utils/Log.dart';

class MimePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MimeState();
}

class _MimeState extends State<MimePage> {
  @override
  void initState() {
    super.initState();
    Log.logT("MimePage", "initState");
  }

  GlobalKey<ArticleListState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Log.logT("MimePage", "build");
    return Scaffold(
        appBar: AppBar(
          title: Text("我的"),
        ),
        body: Column(
          children: <Widget>[
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                Text("${User().isLogin() ? User().userName : "还没有登录请先登录"}"),
                RaisedButton(
                  onPressed: () {
                    if (User().isLogin()) {
                      _showLogoutConfirmDialog(context);
                    } else {
                      openLoginRegister(context);
                    }
                  },
                  child: Text("${User().isLogin() ? "logout" : "login"}"),
                ),
              ],
            ),
            Expanded(
                child: ArticleListWidget(
                    key: globalKey,
                    request: (page) {
                      return HttpService().getCollectArticle(page);
                    }))
          ],
        ));
  }

  void openLoginRegister(BuildContext context) async  {
    var openLoginRegister =await Router.openLoginRegister(context);
    bool isReload=openLoginRegister["isReload"];
    Log.logT("MimePage", "openLoginRegister $isReload");
    if(isReload){
      globalKey.currentState.reLoadData();
    }
  }

  ///显示确认退出对话框
  Future<Null> _showLogoutConfirmDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return _buildLogoutConfirmDialog(context);
        });
  }

  Widget _buildLogoutConfirmDialog(BuildContext context) {
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
              setState(() {});
            });
            Navigator.pop(context);
            globalKey.currentState.reLoadData();
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
