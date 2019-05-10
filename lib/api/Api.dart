class Api {
  static final String _baseUrl = "https://www.wanandroid.com";

  ///首页bannerUrl
  static String HOME_BANNER_URL = _baseUrl + "/banner/json";

  ///首页文章数据
  static String HOME_ARTICLE_LIST_URL = _baseUrl + "/article/list/";

  ///获取公众号列表
  static String HOME_WXARTICLE_CHAPTERS_URL =
      _baseUrl + "/wxarticle/chapters/json";

  ///查看某个公众号历史数据
  static String HOME_WXARTICLE_LIST_URL = _baseUrl + "/wxarticle/list";

  ///获取项目列表
  static String PROJECT_CHAPTERS_URL = _baseUrl + "/project/tree/json";

  ///查看某个项目列表数据
  static String PROJECT_LIST_URL = _baseUrl + "/project/list";

  ///登录接口
  static String LOGIN_URL = _baseUrl + "/user/login";

  /// 注册接口
  static String REGISTER_URL = _baseUrl + "/user/register";

  ///退出接口
  static String LOGOUT_URL = _baseUrl + "/user/logout/json";

  /// 收藏文章列表
  static String COLLECT_LIST_URL = _baseUrl + "/lg/collect/list/";

  ///收藏站内文章
  ///https://www.wanandroid.com/lg/collect/1165/json
  static String COLLECT_URL = _baseUrl + "/lg/collect/";

  ///取消收藏
  ///https://www.wanandroid.com/lg/uncollect_originId/2333/json
  static String UNCOLLECT_URL = _baseUrl + "/lg/uncollect_originId/";


}
