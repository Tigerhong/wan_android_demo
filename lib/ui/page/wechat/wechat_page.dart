import 'package:flutter/material.dart';
import 'package:wan_android_demo/api/HttpService.dart';
import 'package:wan_android_demo/fonts/IconF.dart';
import 'package:wan_android_demo/model/wechat/WeChatItemModel.dart';
import 'package:wan_android_demo/model/wechat/WeChatModel.dart';
import 'package:wan_android_demo/ui/page/article_list/ArticleListWidget.dart';
import 'package:wan_android_demo/utils/Log.dart';

class WeCahtPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WeCahtState();
}

class _WeCahtState extends State<WeCahtPage> with TickerProviderStateMixin {
  TabController controller;
  List<WeChatItemModel> _list = List();

  @override
  void initState() {
    super.initState();
    HttpService().getWxArticleChapters((WeChatModel bean) {
      List<WeChatItemModel> data = bean.data;
      Log.logT("_WeCahtState", " 公众号数据${bean.data.length}");
      if (data?.length > 0) {
        _list = data;
        controller = TabController(length: _list.length, vsync: this);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("公众号"),
        actions: <Widget>[IconButton(icon: Icon(IconF.search))],
        bottom: _list.length > 0
            ? TabBar(
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.only(bottom: 2),
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                indicatorWeight: 1.0,
                controller: controller,
                tabs: _list.map((WeChatItemModel _bean) {
                  return Tab(text: _bean?.name);
                }).toList())
            : null,
      ),
      body: _list.length > 0
          ? TabBarView(
              controller: controller,
              children: _list.map((WeChatItemModel _bean) {
                return ArticleListWidget(
                    headerCount: 0,
                    request: (page) {
                      return HttpService().getWxArticleListById(_bean.id, page);
                    });
              }).toList())
          : Center(
              child: Text("暂无数据"),
            ),
    );
  }
}
