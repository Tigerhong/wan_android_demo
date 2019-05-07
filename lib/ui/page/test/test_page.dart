import 'package:flutter/material.dart';
import 'package:wan_android_demo/ui/widget/HeadFootListWidget.dart';
import 'package:wan_android_demo/utils/Log.dart';

class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProjectState();
}

class _ProjectState extends State<ProjectPage> {
  var TAG = "listview";
  int _dataCount = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("测试自定义listview"),
        ),
        body: HeadFootListWidget(
          _listItemCreator,
          _dataCount,
          headerItemCreator: _headerItemCreator,
          headerItemCount: 2,
          footerItemCreator: _FooterItemCreator,
          footererItemCount: 3,
          moreListener: _moreListener,
          moreCreator: _moreCreator,
          refreshListener: _refreshListener,
        ));
  }

  Widget _listItemCreator(BuildContext context, int index) {
    return Text("我是item$index");
  }

  Widget _headerItemCreator(BuildContext context, int index) {
    return Text("我是header$index");
  }

  Widget _FooterItemCreator(BuildContext context, int index) {
    return Text("我是Footer$index");
  }

  loadMore() {
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _dataCount += 10;
      });
    });
  }

  Future<void> _moreListener() async {
    await Future.delayed(Duration(seconds: 2), () {
      _dataCount += 10;
      setState(() {});
    });
  }

  Widget _moreCreator(BuildContext context) {
    return Container(
      height: 50,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[CircularProgressIndicator(),Container(margin: EdgeInsets.all(10),child: Text("努力加载中....."),)],
        ),
      ),
    );
  }

  Future<void> _refreshListener() async {
    Log.log('======滑动到最顶部======');
    await Future.delayed(Duration(seconds: 2), () {
      _dataCount = 10;
      setState(() {});
    });
  }
}


