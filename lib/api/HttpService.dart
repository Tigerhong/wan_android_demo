import 'package:dio/dio.dart';
import 'package:wan_android_demo/api/Api.dart';
import 'package:wan_android_demo/common/User.dart';
import 'package:wan_android_demo/model/home/homeArticle/HomeArticleModel.dart';
import 'package:wan_android_demo/model/home/homebanner/HomeBannerModel.dart';
import 'package:wan_android_demo/model/porjectClassification/ProjectClassificationModel.dart';
import 'package:wan_android_demo/model/systemdata/SystemDataModel.dart';
import 'dart:convert';
import 'package:wan_android_demo/utils/Log.dart';

class HttpService {
  String TAG = 'HttpService';

  get _getOptions => Options(headers: User().getHeader());

  Future<HomeBannerModel> getBanner() async {
    return await Dio()
        .get(Api.HOME_BANNER_URL, options: _getOptions)
        .then((response) {
      Log.log("getBanner", tag: "HomeBannerModel");
      return HomeBannerModel.fromJson(response.data);
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
  Future<ProjectClassificationModel> getWxArticleChapters() async {
    return await Dio()
        .get(Api.HOME_WXARTICLE_CHAPTERS_URL, options: _getOptions)
        .then((response) {
      return ProjectClassificationModel.fromJson(response.data);
    });
  }

  Future<HomeArticleModel> getWxArticleListById(int authorId, int page) async {
    return await Dio()
        .get(Api.HOME_WXARTICLE_LIST_URL + "/$authorId/$page/json",
            options: _getOptions)
        .then((rep) {
      return HomeArticleModel.fromJson(rep.data);
    });
  }

  ///获取项目列表
  Future<ProjectClassificationModel> getPorjectChapters() async {
    return await Dio()
        .get(Api.PROJECT_CHAPTERS_URL, options: _getOptions)
        .then((response) {
      return ProjectClassificationModel.fromJson(response.data);
    });
  }

  Future<HomeArticleModel> getPorjectListById(int cid, int page) async {
    return await Dio()
        .get(Api.PROJECT_LIST_URL + "/$page/json?cid=$cid",
            options: _getOptions)
        .then((rep) {
      return HomeArticleModel.fromJson(rep.data);
    });
  }

  ///登录
  Future<Response> login(String username, String password) async {
    FormData formData = new FormData.from({
      "username": "$username",
      "password": "$password",
    });
    return await Dio().post(Api.LOGIN_URL, data: formData);
  }

  ///注册
  Future<Response> register(String userName, String password) async {
    FormData formData = new FormData.from({
      "username": "$userName",
      "password": "$password",
      "repassword": "$password",
    });
    return await Dio().post(Api.REGISTER_URL, data: formData);
  }

  ///获取 收藏文章列表
  Future<HomeArticleModel> getCollectArticle(int page) async {
    return await Dio()
        .get(Api.COLLECT_LIST_URL + "$page/json", options: _getOptions)
        .then((response) {
      //在没有登录的情况下，该接口会返回json，
      // 但是类型是string而不是_InternalLinkedHashMap<String, dynamic>，就会出现解析不了报错
      Log.logT(
          TAG, "getCollectArticle  response.data ${response.data.runtimeType}");
      var jsonMap = response.data;
      if (jsonMap is String) {
        jsonMap = json.decode(response.data);
      }
      Log.logT(TAG, "getCollectArticle  jsonMap ${jsonMap.runtimeType}");
      return HomeArticleModel.fromJson(jsonMap);
    });
  }

  ///收藏站内文章
  void postCollectArticle(int id, Function callBack) async {
    await Dio()
        .post(Api.COLLECT_URL + "$id/json", options: _getOptions)
        .then((res) {
      var jsonMap = res.data;
      if (jsonMap is String) {
        jsonMap = json.decode(res.data);
      }
      Log.logT(TAG,
          "postCollectArticle   ${res.data}   ${jsonMap["errorCode"] == 0}");
      callBack(jsonMap["errorCode"] == 0, jsonMap["errorMsg"]);
    });
  }

  ///取消收藏
  void postUncollectArticle(int id, Function callBack) async {
    await Dio()
        .post(Api.UNCOLLECT_URL + "$id/json", options: _getOptions)
        .then((res) {
      var jsonMap = res.data;
      if (jsonMap is String) {
        jsonMap = json.decode(res.data);
      }
      Log.logT(TAG,
          "postUncollectArticle  ${res.data}  ${jsonMap["errorCode"] == 0}");
      callBack(jsonMap["errorCode"] == 0, jsonMap["errorMsg"]);
    });
  }

  ///获取体系数据
  Future<SystemDataModel> getSystemDataList() async {
    return await Dio()
        .get(Api.SYSTEM_DATA_LIST_URL, options: _getOptions)
        .then((rep) {
      return SystemDataModel.fromJson(rep.data);
    });
  }

  /// 知识体系下的文章
  Future<HomeArticleModel> getSystemDataInfoById(int cid, int page) async {
    return await Dio()
        .get(Api.SYSTEM_DATA_INFO_URL + "/$page/json?cid=$cid",
            options: _getOptions)
        .then((rep) {
      return HomeArticleModel.fromJson(rep.data);
    });
  }
}
