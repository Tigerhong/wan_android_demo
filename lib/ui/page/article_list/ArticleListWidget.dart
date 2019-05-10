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
  String TAG;
  RequestData request;
  int headerCount;
  Widget header;

  ArticleListWidget(
      {Key key,
      this.TAG = "ArticleListWidget",
      this.headerCount = 0,
      this.header,
      @required this.request})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ArticleListState();
}

class ArticleListState extends State<ArticleListWidget>
    with AutomaticKeepAliveClientMixin {
  ///继承AutomaticKeepAliveClientMixin用以是widget能保存
  List<HomeArticleItemModel> _articleDatas = List();
  int page = 0;
  int _articleSize = 0;
  bool _isShowFAB = false;
  String emptyStr = "loading...";

  @override
  void initState() {
    super.initState();
    Log.logT(widget.TAG, "initState()");
    _getArticleData(page);
  }

  @override
  void dispose() {
    Log.logT(widget.TAG, "dispose()");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _articleDatas.length == 0
          ? new Center(
              child: Text(emptyStr),
            )
          : HeadFootListWidget(
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

  ///重新加载数据
  void reLoadData() {
    Log.log("reLoadData", tag: widget.TAG);
    _getArticleData(page = 0);
  }

  Future<void> _refreshListener() async {
//    await widget.request(page = 0).then((bean) {
//      if (!mounted) {
//        return;
//      }
//      _articleDatas.clear();
//      _articleSize = bean.data.size;
//      Log.log("当前是第$page页，共$_articleSize", tag: "getArticleData");
//      List<HomeArticleItemModel> data = bean.data.datas;
//      _articleDatas.addAll(data);
//      setState(() {});
//    });
    _getArticleData(page = 0);
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
      if (page == 0) {
        //当page==0的时候，说明下拉刷新，需要将数据重置
        _articleDatas.clear();
        _articleSize = _articleDatas.length;
      }
      if (bean.errorCode == 0) {
        _articleSize += bean?.data?.datas?.length ?? 0;
        Log.log("当前是第$page页，共$_articleSize", tag: "getArticleData");
        if (_articleSize == 0) {
          emptyStr = "暂无数据";
          Log.log("$emptyStr", tag: "getArticleData");
        } else {
          List<HomeArticleItemModel> data = bean.data.datas;
          _articleDatas.addAll(data);
        }
      } else {
        emptyStr = bean.errorMsg;
        Log.log("${bean.errorMsg}", tag: "getArticleData");
      }
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

  @override
  bool get wantKeepAlive => true;
}
