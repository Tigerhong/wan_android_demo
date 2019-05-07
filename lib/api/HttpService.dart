import 'package:dio/dio.dart';
import 'package:wan_android_demo/api/Api.dart';
import 'package:wan_android_demo/model/home/homeArticle/HomeArticleModel.dart';
import 'package:wan_android_demo/model/home/homebanner/HomeBannerModel.dart';
import 'package:wan_android_demo/model/porjectClassification/ProjectClassificationModel.dart';

class HttpService {
  get _getOptions => Options();

  void getBanner(Function callback) async {
    Dio().get(Api.HOME_BANNER_URL, options: _getOptions).then((response) {
      callback(HomeBannerModel.fromJson(response.data));
    });
  }

  Future<HomeArticleModel> getArticle(int page) async {
    return await Dio()
        .get(Api.HOME_ARTICLE_LIST_URL + "$page/json", options: _getOptions)
        .then((rep) {
      return HomeArticleModel.fromJson(rep.data);
    });
  }

  ///获取公众号列表
  void getWxArticleChapters(Function callback) async {
    Dio().get(Api.HOME_WXARTICLE_CHAPTERS_URL, options: _getOptions).then((response) {
      callback(ProjectClassificationModel.fromJson(response.data));
    });
  }

  Future<HomeArticleModel> getWxArticleListById(int authorId,int page) async {
    return await Dio()
        .get(Api.HOME_WXARTICLE_LIST_URL + "/$authorId/$page/json", options: _getOptions)
        .then((rep) {
      return HomeArticleModel.fromJson(rep.data);
    });
  }
  ///获取项目列表
  void getPorjectChapters(Function callback) async {
    Dio().get(Api.PROJECT_CHAPTERS_URL, options: _getOptions).then((response) {
      callback(ProjectClassificationModel.fromJson(response.data));
    });
  }
  Future<HomeArticleModel> getPorjectListById(int cid,int page) async {
    return await Dio()
        .get(Api.PROJECT_LIST_URL + "/$page/json?cid=$cid", options: _getOptions)
        .then((rep) {
      return HomeArticleModel.fromJson(rep.data);
    });
  }
}
