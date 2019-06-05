import 'package:flutter/material.dart';
import 'package:wan_android_demo/api/HttpService.dart';
import 'package:wan_android_demo/common/Router.dart';
import 'package:wan_android_demo/model/home/homebanner/HomeBannerItemModel.dart';
import 'package:wan_android_demo/ui/page/article_list/ArticleListWidget.dart';

import 'package:wan_android_demo/ui/widget/BannerWidget.dart';
import 'package:wan_android_demo/ui/widget/CAppBar.dart';
import 'package:wan_android_demo/ui/widget/NetworkWrapWidget.dart';
import 'package:wan_android_demo/utils/Log.dart';

class BlogPage extends StatefulWidget {
  String title;

  BlogPage({this.title});

  @override
  State<StatefulWidget> createState() => _BlogState();
}

class _BlogState extends State<BlogPage> {
  List<HomeBannerItemModel> _data = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CAppBar(
          title: widget.title,
        ),
        body: NetworkWrapWidget(
          widget: ArticleListWidget(
            TAG: "_BlogState_ArticleListWidget",
            request: (page) {
              return HttpService().getArticle(page);
            },
            headerCount: 1,
            header: getBanner(),
          ),
          call: _getBannerData,
        ));
  }

  Widget getBanner() {
    List<Widget> page = List();
    for (HomeBannerItemModel bean in _data) {
      page.add(GestureDetector(
        onTap: () {
          Router.openWeb(context, bean.url, bean.title);
        },
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: <Widget>[
            Center(child: CircularProgressIndicator()),
            Image.network(
              bean.imagePath,
              fit: BoxFit.fill,
            )
          ],
        ),
      ));
    }
    return BannerWidget(itemPage: page);
  }

  ///加载banner数据
  Future _getBannerData() async {
    var homeBannerModel = await HttpService().getBanner();
    Log.log("1111", tag: "HomeBannerModel");
    if (!mounted) {
      return Future.value(true);
    }
    if (homeBannerModel.data.length > 0) {
      List<HomeBannerItemModel> data = homeBannerModel.data;
      Log.log("${data.length}", tag: "HomeBannerModel");
      setState(() {
        _data = data;
      });
    }
    return Future.value(true);
  }
}
