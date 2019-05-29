import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:wan_android_demo/api/HttpService.dart';
import 'package:wan_android_demo/common/GlobalConfig.dart';
import 'package:wan_android_demo/common/Router.dart';
import 'package:wan_android_demo/fonts/IconF.dart';
import 'package:wan_android_demo/model/home/homeArticle/HomeArticleItemModel.dart';
import 'package:wan_android_demo/state/provide/RefreshWidget.dart';

///
/// 这里使用了三种方式隐藏view
///
/// * 1.使用san目运算 a?b:c，这种方式只有某一个view是加载出来，
/// * 2.使用Offstage的offstage属性，这种方式view不会被加载出来，但是如果view中有数据加载逻辑，这部分逻辑仍然会被执行
/// * 3.使用Visibility的visible属性，这种方式view不会被加载出来，但是如果view中有数据加载逻辑，这部分逻辑仍然会被执行
class ArticleItemWidget extends StatefulWidget {
  HomeArticleItemModel item;

  ArticleItemWidget(this.item);

  @override
  State<StatefulWidget> createState() => _ArticleItemState(item);
}

class _ArticleItemState<ArticleItemWidget> extends State {
  HomeArticleItemModel item;

  _ArticleItemState(this.item);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Router.openWeb(context, item.link, item.title);
        },
        child: Card(
            margin: EdgeInsets.all(5),
            elevation: 5,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Visibility(
                                //显示隐藏视图方式三，用这种方式，child的数据也是会被绘制的，只是没有显示在界面上
                                visible: item.fresh ?? false,
                                child: Container(
                                  padding: EdgeInsets.only(left: 2, right: 2),
                                  margin: EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(
                                        color: GlobalConfig.colorPrimary),
                                  ),
                                  child: Text("新",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: GlobalConfig.colorPrimary)),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  item.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                IconF.time,
                                size: 16,
                                color: GlobalConfig.color_dark_gray,
                              ),
                              Text(
                                " ${item.niceDate} @${item.author}",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: GlobalConfig.color_dark_gray),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              //显示隐藏视图方式一
                              item.tags != null && item.tags.length > 0
                                  ? Container(
                                      padding:
                                          EdgeInsets.only(left: 2, right: 2),
                                      margin: EdgeInsets.only(right: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(
                                            color: GlobalConfig.color_tags),
                                      ),
                                      child: Text(item.tags[0]?.name,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: GlobalConfig.color_tags)),
                                    )
                                  : Container(),
                              //显示隐藏视图方式二，用这种方式，child的数据也是会被绘制的，只是没有显示在界面上
                              Offstage(
                                offstage: item.tags == null
                                    ? true
                                    : item.tags.length > 0,
                                child: Text(
                                  "分类:",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: GlobalConfig.color_dark_gray),
                                ),
                              ),
                              Offstage(
                                offstage: item.chapterName?.length == 0,
                                child: Text(
                                  "${item.superChapterName == null ? "" : "${item.superChapterName}/"}${item.chapterName}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: GlobalConfig.color_dark_gray),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(
                          item.collect ?? true
                              ? IconF.like_fill
                              : IconF.like_stroke,
                          color: GlobalConfig.colorPrimary,
                        ),
                        onPressed: () {
                          _onPressedCollectBt(context);
                        },
                      ),
                    )
                  ],
                ))));
  }

  ///收藏按钮的点击事件
  void _onPressedCollectBt(BuildContext context) {
    String collect = item.collect ?? true ? "取消收藏" : "收藏";
    var callback = (isSuccess, msg) {
      String tip = "$collect成功";
      if (!isSuccess) {
        tip = msg;
      }
      Toast.show(tip, context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

      Provider.of<RefreshWidget>(context).refresh();
      if (isSuccess) {
        setState(() {
          //这样可以刷新当前item
          item.collect = !item.collect;
        });
      }
    };
    if (item.collect ?? true) {
      HttpService().postUncollectArticle(item.id, callback);
    } else {
      HttpService().postCollectArticle(item.id, callback);
    }
  }
}
