part of 'package:wan_android_demo/model/home/homeArticle/HomeArticleModel.dart';

HomeArticleModel _$HomeArticleModellnFromJson(Map<String, dynamic> json) {
  return HomeArticleModel(
    HomeArticleDataModel.fromJson(json["data"]??Map()),
    json["errorCode"],
    json["errorMsg"],
  );
}
