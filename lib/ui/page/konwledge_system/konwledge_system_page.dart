import 'package:flutter/material.dart';
import 'package:wan_android_demo/api/HttpService.dart';
import 'package:wan_android_demo/common/localization/Language.dart';
import 'package:wan_android_demo/fonts/IconF.dart';
import 'package:wan_android_demo/model/systemdata/SystemDataChildItem.dart';
import 'package:wan_android_demo/model/systemdata/SystemDataItem.dart';
import 'package:wan_android_demo/model/systemdata/SystemDataModel.dart';
import 'package:wan_android_demo/ui/page/article_list/ArticleListWidget.dart';
import 'package:wan_android_demo/ui/widget/CTabBarView.dart';
import 'package:wan_android_demo/utils/Log.dart';

class KnowledgeSystemsPage extends StatefulWidget {
  String title;

  KnowledgeSystemsPage({this.title});

  @override
  State<StatefulWidget> createState() => _KnowledgeSystemsState();
}

class _KnowledgeSystemsState extends State<KnowledgeSystemsPage>
    with TickerProviderStateMixin {
  String TAG = "_KnowledgeSystemsState";
  List<SystemDataItem> data = List();
  int mainIndex = 0;

  TabController controller;
  Map<int, TabController> _tabControllerInnerMaps = Map();

  @override
  void initState() {
    super.initState();
    HttpService().getSystemDataList((SystemDataModel bean) {
      if (!mounted) {
        return;
      }
      setState(() {
        data = bean.data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Log.logT(TAG, "build");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        actions: <Widget>[IconButton(icon: Icon(IconF.search))],
        bottom: _buildTitlBottom(),
      ),
      body: data.length > 0 ? _buildBody() : Text(Language.getString(context).tip_nodata()),
    );
  }

  PreferredSize _appBarBottom;

  _buildTitlBottom() {
    if (null == _appBarBottom && data.length != 0) {
      _appBarBottom = PreferredSize(
          child: _buildTitleTabs(),
          preferredSize: Size(double.infinity, kTextTabBarHeight * 2));
      Log.logT(TAG, "_buildTitlBottom1111");
    }
    Log.logT(TAG, "_buildTitlBottom2222");
    return _appBarBottom;
  }

  _buildTitleTabs() {
    Log.logT(TAG, "_buildTitleTabs data：${data.length}");
    controller = TabController(length: data.length, vsync: this);
    controller.addListener(() {
      mainIndex = controller.index;
      setState(() {});
    });
    return data.length > 0
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TabBar(
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding: EdgeInsets.only(bottom: 2),
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  indicatorWeight: 1.0,
                  controller: controller,
                  tabs: data.map((SystemDataItem _bean) {
                    return Tab(text: _bean?.name);
                  }).toList()),
              Container(
                  width: double.infinity,
                  height: kTextTabBarHeight,
                  alignment: Alignment.topLeft,
                  color: Colors.blue,
                  child: CTabBarView(
                      controller: controller,
                      children: data.map((SystemDataItem bean) {
                        return _buildSecondTabBar(bean);
                      }).toList())),
            ],
          )
        : Text(Language.getString(context).tip_nodata());
  }

  Widget _buildSecondTabBar(SystemDataItem bean) {
    Log.logT(TAG, "_buildSecondTabBar");

    if (null == _tabControllerInnerMaps[bean.id]) {
      _tabControllerInnerMaps[bean.id] =
          TabController(length: bean.children.length, vsync: this);
    }
    return
//      NotificationListener<ScrollNotification>(
//        onNotification: _onNotification,
//        child:
        TabBar(
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.only(bottom: 2),
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            indicatorWeight: 1.0,
            controller: _tabControllerInnerMaps[bean.id],
            tabs: bean.children.map((SystemDataChildItem _bean) {
              return Tab(text: _bean.name);
            }).toList()
//        )
            );
  }

  _buildBody() {
    Log.logT(TAG, "_buildBody");
    return NotificationListener<ScrollNotification>(
        onNotification: _onNotification,
        child: TabBarView(
            key: Key("tb${data[mainIndex].id}"),
            controller: _tabControllerInnerMaps[data[mainIndex].id],
            children: data[mainIndex].children.map((SystemDataChildItem _bean) {
              return ArticleListWidget(
                  key: Key("${_bean.id}"),
                  TAG: "体系${_bean.name}",
                  headerCount: 0,
                  request: (page) {
                    return HttpService().getSystemDataInfoById(_bean.id, page);
                  });
            }).toList()));
  }

  @override
  void dispose() {
    controller?.dispose();
    _tabControllerInnerMaps.forEach((_, controller) {
      controller?.dispose();
    });
    super.dispose();
  }

  DateTime _lastPressedAdt; //上次点击时间 初始化的时候是空，下面会做判断
  bool doubleClickBack() {
    if (_lastPressedAdt == null ||
        DateTime.now().difference(_lastPressedAdt) > Duration(seconds: 1)) {
      //两次点击时间间隔超过1秒则重新计时
      _lastPressedAdt = DateTime.now();
      return false;
    }
    return true;
  }

  bool _onNotification(ScrollNotification notification) {
    String tag = "_onNotification  ";
    if (notification is ScrollEndNotification) {
      //下滑到最底部
      if (notification.metrics.extentAfter == 0.0) {
        var doubleClickBack2 = doubleClickBack();
        Log.logT(tag, "doubleClickBack::::$doubleClickBack2");
        if (!doubleClickBack2) {
          return false;
        }
        Log.logT(tag, "最右边");
        if (mainIndex + 1 < 40) {
          mainIndex += 1;
          controller.animateTo(mainIndex);
        }
      }
      //滑动到最顶部
      if (notification.metrics.extentBefore == 0.0) {
        var doubleClickBack2 = doubleClickBack();
        Log.logT(tag, "doubleClickBack::::$doubleClickBack2");
        if (!doubleClickBack2) {
          return false;
        }
        Log.logT(tag, "最左边");
        if (mainIndex - 1 >= 0) {
          mainIndex -= 1;
          controller.animateTo(mainIndex);
        }
      }
    }
    return false;
  }
}
