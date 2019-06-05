import 'package:flutter/material.dart';
import 'package:wan_android_demo/common/GlobalConfig.dart';
import 'package:wan_android_demo/common/localization/Language.dart';
import 'package:wan_android_demo/fonts/IconF.dart';
import 'package:wan_android_demo/model/home/homeArticle/HomeArticleItemModel.dart';
import 'package:wan_android_demo/model/home/homeArticle/HomeArticleModel.dart';
import 'package:wan_android_demo/ui/page/article_list/ArticleItemWidget.dart';
import 'package:wan_android_demo/ui/widget/HeadFootListWidget.dart';
import 'package:wan_android_demo/ui/widget/NetworkWrapWidget.dart';
import 'package:wan_android_demo/ui/widget/NoDataWidget.dart';
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
  bool isNoData = false;

  @override
  void initState() {
    super.initState();
    Log.logT(widget.TAG, "initState()");
//    _getArticleData(page);
  }

  @override
  void dispose() {
    Log.logT(widget.TAG, "dispose()");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Log.logT(widget.TAG, "build build build");
    return Scaffold(
      body: isNoData
          ? NoDataWidget()
          : NetworkWrapWidget(
              widget: HeadFootListWidget(
                _listItemCreator,
                _articleDatas.length,
                headerItemCount: widget.headerCount,
                headerItemCreator: _headerItemCreator,
                moreListener: _moreListener,
                moreCreator: _moreCreator,
                refreshListener: _refreshListener,
                scrollControllerListener: _scrollControllerListener,
              ),
              call: getArticleData,
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

  Future _moreListener() async {
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

  Future _refreshListener() async {
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

  Future getArticleData() async {
    return await _getArticleData(page);
  }

  ///加载文章数据
  Future _getArticleData(int page) async {
    return await widget.request(page).then((bean) {
      if (!mounted) {
        return Future.value(true);
      }
      if (page == 0) {
        //当page==0的时候，说明下拉刷新，需要将数据重置
        _articleDatas.clear();
        _articleSize = _articleDatas.length;
      }
      if (bean.errorCode == 0) {
        _articleSize += bean?.data?.datas?.length ?? 0;
        Log.log("当前是第$page页共${bean?.data?.pageCount}页，共${bean?.data?.total}条数据",
            tag: "${widget.TAG} getArticleData");
        if (_articleSize == 0) {
          String emptyStr = Language.getString(context).tip_nodata();
          Log.log("$emptyStr", tag: "${widget.TAG} getArticleData");
          if (page == 0) {
            isNoData = true;
          }
        } else {
          List<HomeArticleItemModel> data = bean.data.datas;
          _articleDatas.addAll(data);
        }
        setState(() {});
        return Future.value(true);
      } else {
        Log.log("${bean.errorMsg}", tag: "${widget.TAG} getArticleData");
        return Future.value(false);
      }
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
