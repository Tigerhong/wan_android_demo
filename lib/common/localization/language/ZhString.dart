import 'package:wan_android_demo/common/localization/language/base/WAStringBase.dart';

///语言实体实现类
class ZhString extends WAStringBase {
  @override
  String app_name() => "玩Android Flutter 应用";

  @override
  String welcome_title()=> "您好,欢迎来到 WanAndroid Flutter App !!!";

  String tip_nodata() => "暂无数据";

  @override
  String tip_loading() => "加载中...";

  @override
  String app_bowen() => "博文";

  @override
  String app_project() => "项目";

  @override
  String app_wechat() => "公众号";

  @override
  String app_systems() => "体系";

  @override
  String login() => "登录";

  @override
  String logout() => "退出登录";

  @override
  String article_collect() => "文章收藏";

  @override
  String switch_language() => "切换语言";

  @override
  String switch_theme() => "切换主题";

  @override
  String login_title() => "登录";

  @override
  String login_title_regise() => "注册";

  @override
  String login_user_name() => "用户名";

  @override
  String login_user_password() => "密码";

  @override
  String login_text_regiser() => "注册新账号";

  @override
  String login_text_login() => "直接登录";

  @override
  String login_user_name_hint() => "请输入用户名";

  @override
  String login_user_password_hint() => "请输入密码";

  @override
  String login_no_password() => "密码不能为空";

  @override
  String login_no_user_name() => "用户名不能为空";

  @override
  String login_success() => "登录成功";
}
