import 'package:flutter/material.dart';
import 'package:wan_android_demo/api/HttpService.dart';
import 'package:wan_android_demo/common/Router.dart';
import 'package:wan_android_demo/common/localization/Language.dart';
import 'package:wan_android_demo/fonts/IconF.dart';
import 'package:wan_android_demo/model/home/homebanner/HomeBannerItemModel.dart';
import 'package:wan_android_demo/model/home/homebanner/HomeBannerModel.dart';
import 'package:wan_android_demo/ui/page/article_list/ArticleListWidget.dart';

import 'package:wan_android_demo/ui/widget/BannerWidget.dart';
import 'package:wan_android_demo/ui/widget/CAppBar.dart';
import 'package:wan_android_demo/utils/Log.dart';

class BlogPage extends StatefulWidget {
  String title;

  BlogPage({this.title});

  @override
  State<StatefulWidget> createState() => _BlogState();
}

class _BlogState extends State<BlogPage> {
  List<HomeBannerItemModel> _data;

  @override
  void initState() {
    super.initState();
    _getBannerData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        title: widget.title,
      ),
      body: ArticleListWidget(
        request: (page) {
          return HttpService().getArticle(page);
        },
        headerCount: 1,
        header: getBanner(),
      ),
    );
  }

  Widget getBanner() {
    if (_data == null) {
      return Container(
          child: Center(
        child: Text(Language.getString(context).tip_loading()),
      ));
    } else {
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
  }

  ///加载banner数据
  void _getBannerData() {
    HttpService().getBanner((HomeBannerModel _bean) {
      if (!mounted) {
        return;
      }
      if (_bean.data.length > 0) {
        List<HomeBannerItemModel> data = _bean.data;
        Log.log("${data.length}", tag: "HomeBannerModel");
        setState(() {
          _data = data;
        });
      }
    });
  }
}
