import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wan_android_demo/common/User.dart';
import 'package:wan_android_demo/common/localization/Language.dart';
import 'package:wan_android_demo/fonts/IconF.dart';
import 'package:wan_android_demo/state/provide/OpenDrawerWidget.dart';
import 'package:wan_android_demo/ui/widget/AppDrawer.dart';
import 'package:wan_android_demo/ui/page/blog/blog_page.dart';
import 'package:wan_android_demo/ui/page/konwledge_system/konwledge_system_page.dart';
import 'package:wan_android_demo/ui/page/project/project_page.dart';
import 'package:wan_android_demo/ui/page/wechat/wechat_page.dart';
import 'package:wan_android_demo/utils/Log.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  String TAG = "_AppState";
  int _currentIndex = 0;
  List<String> titles = [];
  PageController _pageController;
  List<BottomNavigationBarItem> _bottomItems = [];
  List<Widget> _page = [];

  @override
  void didUpdateWidget(App oldWidget) {
    super.didUpdateWidget(oldWidget);
    Log.logT(TAG, "didUpdateWidget");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Log.logT(TAG, "didChangeDependencies");
    titles = [
      Language.getString(context).app_bowen(),
      Language.getString(context).app_project(),
      Language.getString(context).app_wechat(),
      Language.getString(context).app_systems()
    ];
    _bottomItems = [
      BottomNavigationBarItem(
        icon: Icon(IconF.blog),
        title: Text(titles[0]),
      ),
      BottomNavigationBarItem(
        icon: Icon(IconF.project),
        title: Text(titles[1]),
      ),
      BottomNavigationBarItem(
        icon: Icon(IconF.wechat),
        title: Text(titles[2]),
      ),
      BottomNavigationBarItem(
        icon: Icon(IconF.tree),
        title: Text(titles[3]),
      ),
    ];
    _page = [
      BlogPage(title: titles[0]),
      ProjectPage(title: titles[1]),
      WeCahtPage(title: titles[2]),
      KnowledgeSystemsPage(title: titles[3]),
    ];
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
GlobalKey<ScaffoldState> key=GlobalKey();
  @override
  Widget build(BuildContext context) {
    User().refreshUserData();

    var scaffold = Scaffold(
      key: key,
      drawer: AppDrawer(),
      //Center控件使其子控件在中间位置
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: _page,
        onPageChanged: _onPageChanged,
        controller: _pageController,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _bottomItems,
//            fixedColor:  Colors.red,
        currentIndex: _currentIndex,
        onTap: (int index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
    Provider.of<OpenDrawerhWidget>(context).addListener(() {
      Log.logT("_AppDrawer", "OpenDrawerhWidget+++++++");
      key.currentState.openDrawer();
    });
    return scaffold;
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
