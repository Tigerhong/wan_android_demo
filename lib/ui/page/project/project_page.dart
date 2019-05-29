import 'package:flutter/material.dart';
import 'package:wan_android_demo/api/HttpService.dart';
import 'package:wan_android_demo/common/localization/Language.dart';
import 'package:wan_android_demo/fonts/IconF.dart';
import 'package:wan_android_demo/model/porjectClassification/ProjectClassificationItemModel.dart';
import 'package:wan_android_demo/model/porjectClassification/ProjectClassificationModel.dart';
import 'package:wan_android_demo/ui/page/article_list/ArticleListWidget.dart';
import 'package:wan_android_demo/ui/widget/CAppBar.dart';
import 'package:wan_android_demo/utils/Log.dart';

class ProjectPage extends StatefulWidget {
  String title;

  ProjectPage({this.title});

  @override
  State<StatefulWidget> createState() => _ProjectState();
}

class _ProjectState extends State<ProjectPage> with TickerProviderStateMixin {
  TabController controller;
  List<ProjectClassificationItemModel> _list = List();

  @override
  void initState() {
    super.initState();
    HttpService().getPorjectChapters((ProjectClassificationModel bean) {
      List<ProjectClassificationItemModel> data = bean.data;
      Log.logT("_ProjectState", " 项目数据${bean.data.length}");
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
      appBar: CAppBar(
        title: widget.title,
        bottom: _list.length > 0
            ? TabBar(
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.only(bottom: 2),
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                indicatorWeight: 1.0,
                controller: controller,
                tabs: _list.map((ProjectClassificationItemModel _bean) {
                  return Tab(text: _bean?.name);
                }).toList())
            : null,
      ),
      body: _list.length > 0
          ? TabBarView(
              controller: controller,
              children: _list.map((ProjectClassificationItemModel _bean) {
                return ArticleListWidget(
                    TAG: "项目${_bean.name}",
                    headerCount: 0,
                    request: (page) {
                      return HttpService().getPorjectListById(_bean.id, page);
                    });
              }).toList())
          : Center(
              child: Text(Language.getString(context).tip_nodata()),
            ),
    );
  }
}
