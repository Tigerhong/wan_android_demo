import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wan_android_demo/utils/Log.dart';

///
typedef HeaderItemCreator = Widget Function(BuildContext context, int index);

typedef FooterItemCreator = Widget Function(BuildContext context, int index);

typedef ListItemCreator = Widget Function(BuildContext context, int index);

typedef MoreCreator = Widget Function(BuildContext context);

typedef MoreListener = Future<void> Function();

typedef RefreshListener = Future<void> Function();
typedef ScrollControllerListener = Function(ScrollController sc);

///含有头部，尾部视图的Listview，且支持下拉刷新，上拉加载更多
///
///* 说明文档444
///* 999
// ignore: must_be_immutable
class HeadFootListWidget extends StatefulWidget {
  ///头部视图构建者
  HeaderItemCreator headerItemCreator;

  ///尾部视图构建者
  FooterItemCreator footerItemCreator;

  ///item构建者
  ListItemCreator listItemCreator;

  ///加载更多构建者
  MoreCreator moreCreator;

  ///加载更多监听者
  MoreListener moreListener;

  ///下拉刷新监听
  RefreshListener refreshListener;

  ///滑动监听
  ScrollControllerListener scrollControllerListener;

  ///头部视图数量，默认为0
  int headerItemCount;

  ///尾部视图数量，默认为0
  int footererItemCount;

  ///item数量
  int listItemCount;

  ///判断是否开启下拉刷新
  bool isCanDropDownRefresh;

  ///含有头部，尾部视图的listview，且支持下拉刷新，上啦加载更多
  HeadFootListWidget(this.listItemCreator, this.listItemCount,
      {this.headerItemCreator,
      this.headerItemCount = 0,
      this.footererItemCount = 0,
      this.footerItemCreator,
      this.moreListener,
      this.moreCreator,
      this.refreshListener,
      this.scrollControllerListener}) {
    isCanDropDownRefresh = refreshListener != null;
  }

  @override
  State<StatefulWidget> createState() => _HeadFootListState();
}

class _HeadFootListState extends State<HeadFootListWidget> {
  static const TAG = "_HeadFootListState";
  int moreCount = 0;

  ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      ScrollControllerListener scrollControllerListener =
          widget.scrollControllerListener;
      if (scrollControllerListener != null) {
        widget.scrollControllerListener(_scrollController);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: _onNotification,
      child: RefreshIndicator(
          notificationPredicate: (notification) =>
              widget.isCanDropDownRefresh && !isLoading,
          child: ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: _getItemCount(),
              itemBuilder: _itemBuilder),
          onRefresh: _onRefresh),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    if (index < _getHeaderViewCount()) {
      //计算头部布局
      return widget.headerItemCreator(context, index);
    } else if (index < (_getHeaderViewCount() + widget.listItemCount)) {
      //计算item布局
      int realIndex = index - _getHeaderViewCount();
      return widget.listItemCreator(context, realIndex);
    } else if (index < _getItemCount() - moreCount) {
      //计算尾部布局
      int realIndex = index - (_getHeaderViewCount() + widget.listItemCount);
      return widget.footerItemCreator(context, realIndex);
    } else {
      //计算加载更多布局
      return widget.moreCreator(context);
    }
  }

  ///listview总item数
  int _getItemCount() {
    return _getHeaderViewCount() +
        _getFooterViewCount() +
        widget.listItemCount +
        moreCount;
  }

  ///尾部视图个数
  int _getFooterViewCount() {
    return widget.footererItemCount;
  }

  ///头部视图个数
  int _getHeaderViewCount() {
    return widget.headerItemCount;
  }

  bool _onNotification(Notification notification) {
    if (widget.moreListener == null || widget.moreCreator == null) {
      Log.log(
          "widget.moreListener is ${widget.moreListener == null ? "exit" : "noExit"} or"
          " widget.moreCreator is ${widget.moreCreator == null ? "exit" : "noExit"}",
          tag: "_onNotification");
      return true;
    }
    if (notification is UserScrollNotification) {
      ScrollDirection direction = notification.direction;
      //这里不再需要判断下拉了。
//      if (ScrollDirection.forward == direction) {
//        //下拉
//        if (notification.metrics.extentBefore == 0.0) {
//          Log.log('======_onNotification滑动到最顶部$isLoading======', tag: TAG);
//
//        }
//      } else
      if (ScrollDirection.reverse == direction) {
        //上啦
        if (notification.metrics.extentAfter == 0.0) {
          Log.log('======_onNotification下滑到最底部$isLoading======', tag: TAG);
          _loadMore();
        }
      }
    }
    return true;
  }

  ///隐藏下拉加载更多控件
  void _hideMoreView() {
    moreCount = 0;
    setState(() {});
  }

  ///显示加载更多控件
  void _showMoreView() {
    moreCount = 1;
    setState(() {});
  }

  Future<Null> _onRefresh() async{
    Log.logT(TAG, "_onRefresh：$isLoading");
    isLoading = true;
    _hideMoreView();
    return await widget.refreshListener().whenComplete(() {
      isLoading = false;
    });
  }

  void _loadMore() async{
    if (isLoading) return;
    isLoading = true;
    _showMoreView();
    await widget.moreListener().whenComplete(() {
      isLoading = false;
      _hideMoreView();
    });
  }
}
