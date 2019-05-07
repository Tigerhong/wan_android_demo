import 'package:json_annotation/json_annotation.dart';
import 'package:wan_android_demo/model/home/homeArticle/HomeArticleItemModel.dart';

part 'HomeArticleDataModel.g.dart';

@JsonSerializable()
class HomeArticleDataModel {
  int curPage;
  int offset;
  List<HomeArticleItemModel> datas;
  bool over;
  int pageCount;
  int size;
  int total;

  factory HomeArticleDataModel.fromJson(Map<String, dynamic> json)=>_HomeArticleDataModelFromJson(json);

  HomeArticleDataModel(
      {this.curPage,
      this.offset,
      this.datas,
      this.over,
      this.pageCount,
      this.size,
      this.total});
}
