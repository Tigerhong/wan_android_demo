import 'package:flutter/material.dart';
import 'package:wan_android_demo/common/GlobalConfig.dart';
import 'package:wan_android_demo/common/Router.dart';
import 'package:wan_android_demo/fonts/IconF.dart';
import 'package:wan_android_demo/model/home/homeArticle/HomeArticleItemModel.dart';
///
/// 这里使用了三种方式隐藏view
///
/// * 1.使用san目运算 a?b:c，这种方式只有某一个view是加载出来，
/// * 2.使用Offstage的offstage属性，这种方式view不会被加载出来，但是如果view中有数据加载逻辑，这部分逻辑仍然会被执行
/// * 3.使用Visibility的visible属性，这种方式view不会被加载出来，但是如果view中有数据加载逻辑，这部分逻辑仍然会被执行
class ArticleItemWidget extends StatelessWidget {
  HomeArticleItemModel item;

  ArticleItemWidget(this.item);

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Visibility(
                        //显示隐藏视图方式三，用这种方式，child的数据也是会被绘制的，只是没有显示在界面上
                        visible: item.fresh,
                        child: Container(
                          padding: EdgeInsets.only(left: 2, right: 2),
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border:
                                Border.all(color: GlobalConfig.colorPrimary),
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
                            fontSize: 16, color: GlobalConfig.color_dark_gray),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      //显示隐藏视图方式一
                      item.tags != null && item.tags.length > 0
                          ? Container(
                              padding: EdgeInsets.only(left: 2, right: 2),
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                border:
                                    Border.all(color: GlobalConfig.color_tags),
                              ),
                              child: Text(item.tags[0]?.name,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: GlobalConfig.color_tags)),
                            )
                          : Container(),
                      //显示隐藏视图方式二，用这种方式，child的数据也是会被绘制的，只是没有显示在界面上
                      Offstage(
                        offstage: item.tags != null && item.tags.length > 0,
                        child: Text(
                          "分类  ",
                          style: TextStyle(
                              fontSize: 16,
                              color: GlobalConfig.color_dark_gray),
                        ),
                      ),
                      Text(
                        "${item.superChapterName}/${item.chapterName}",
                        style: TextStyle(
                            fontSize: 16, color: GlobalConfig.color_dark_gray),
                      )
                    ],
                  )
                ],
              ),
            )));
  }
}
