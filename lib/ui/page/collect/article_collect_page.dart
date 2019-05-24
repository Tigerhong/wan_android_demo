import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:wan_android_demo/api/HttpService.dart';
import 'package:wan_android_demo/state/provide/RefreshWidget.dart';
import 'package:wan_android_demo/ui/page/article_list/ArticleListWidget.dart';
import 'package:wan_android_demo/utils/Log.dart';

class ArticleCollectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MimeState();
}

class _MimeState extends State<ArticleCollectPage> {
  @override
  void initState() {
    super.initState();
    Log.logT("ArticleCollectPage", "initState");
  }

  GlobalKey<ArticleListState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final currentCounter = Provide.value<RefreshWidget>(context);
    currentCounter.addListener(() {
      Log.logT("ArticleCollectPage", "setListener+++++++");
      globalKey?.currentState?.reLoadData();
    });
    Log.logT("ArticleCollectPage", "build");
    return Scaffold(
        appBar: AppBar(
          title: Text("文章收藏列表"),
        ),
        body: ArticleListWidget(
            key: globalKey,
            request: (page) {
              return HttpService().getCollectArticle(page);
            }));
  }
}
