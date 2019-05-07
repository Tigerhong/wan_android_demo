
import 'package:wan_android_demo/model/BaseModel.dart';
import 'package:wan_android_demo/model/home/homeArticle/HomeArticleDataModel.dart';
part 'package:wan_android_demo/model/home/homeArticle/HomeArticleModel.g.dart';
class HomeArticleModel extends BaseModel<HomeArticleDataModel>{

  HomeArticleModel(HomeArticleDataModel data, int errorCode, String errorMsg) : super(data, errorCode, errorMsg);

  factory HomeArticleModel.fromJson(Map<String, dynamic> json) => _$HomeArticleModellnFromJson(json);
}