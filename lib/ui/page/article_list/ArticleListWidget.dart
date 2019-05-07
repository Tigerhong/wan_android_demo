import 'package:flutter/material.dart';
import 'package:wan_android_demo/common/GlobalConfig.dart';
import 'package:wan_android_demo/fonts/IconF.dart';
import 'package:wan_android_demo/model/home/homeArticle/HomeArticleItemModel.dart';
import 'package:wan_android_demo/model/home/homeArticle/HomeArticleModel.dart';
import 'package:wan_android_demo/ui/page/article_list/ArticleItemWidget.dart';
import 'package:wan_android_demo/ui/widget/HeadFootListWidget.dart';
import 'package:wan_android_demo/utils/Log.dart';

typedef Future<HomeArticleModel> RequestData(int page);

///文章列表页面
class ArticleListWidget extends StatefulWidget {
  RequestData request;
  int headerCount;
  Widget header;

  ArticleListWidget(
      {this.headerCount = 0, this.header, @required this.request});

  @override
  State<StatefulWidget> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleListWidget> {
  List<HomeArticleItemModel> _articleDatas = List();
  int page = 0;
  int _articleSize = 0;
  bool _isShowFAB = false;

  @override
  void initState() {
    super.initState();
    _getArticleData(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HeadFootListWidget(
        _listItemCreator,
        _articleDatas.length,
        headerItemCount: widget.headerCount,
        headerItemCreator: _headerItemCreator,
        moreListener: _moreListener,
        moreCreator: _moreCreator,
        refreshListener: _refreshListener,
        scrollControllerListener: _scrollControllerListener,
      ),
      floatingActionButton: _getFABWidget(),
    );
  }

  Widget _listItemCreator(BuildContext context, int index) {
//    if (_articleDatas.length <= 0 ||
//        index < 0 ||
//        index >= _articleDatas.length) {
//      return null;
//    }
    return ArticleItemWidget(_articleDatas[index]);
  }

  Widget _headerItemCreator(BuildContext context, int index) {
    return widget.header;
  }

  Future<void> _moreListener() async {
    return await _getArticleData(++page);
  }

  Widget _moreCreator(BuildContext context) {
    return Container(
      height: 50,
      child: Center(
        child: Text("loadMore....."),
      ),
    );
  }

  Future<void> _refreshListener() async {
    await widget.request(page = 0).then((bean) {
      if (!mounted) {
        return;
      }
      _articleDatas.clear();
      _articleSize = bean.data.size;
      Log.log("当前是第$page页，共$_articleSize", tag: "getArticleData");
      List<HomeArticleItemModel> data = bean.data.datas;
      _articleDatas.addAll(data);
      setState(() {});
    });
  }

  ScrollController _sc;

  _scrollControllerListener(ScrollController sc) {
    _sc = sc;
    double pixels = sc.position.pixels;
    double height = MediaQuery.of(context).size.height;
    setState(() {
      _isShowFAB = pixels > height;
    });
  }

  ///加载文章数据
  _getArticleData(int page) async {
    await widget.request(page).then((bean) {
      if (!mounted) {
        return;
      }
      _articleSize += bean.data.size;
      Log.log("当前是第$page页，共$_articleSize", tag: "getArticleData");
      List<HomeArticleItemModel> data = bean.data.datas;
      _articleDatas.addAll(data);
      setState(() {});
    });
  }

  Widget _getFABWidget() {
    return _isShowFAB
        ? FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: GlobalConfig.colorPrimary,
            child: Icon(IconF.top),
            onPressed: () {
              handleScroll(0.0);
            })
        : SizedBox(
            height: 0,
            width: 0,
          );
  }

  ///fastOutSlowIn
  void handleScroll(double d) {
    _sc?.animateTo(d,
        duration: new Duration(seconds: 2), curve: Curves.fastOutSlowIn);
  }
}
