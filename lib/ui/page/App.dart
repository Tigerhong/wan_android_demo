import 'package:flutter/material.dart';
import 'package:wan_android_demo/fonts/IconF.dart';
import 'package:wan_android_demo/ui/page/blog/blog_page.dart';
import 'package:wan_android_demo/ui/page/konwledge_system/konwledge_system_page.dart';
import 'package:wan_android_demo/ui/page/mime/blog_page.dart';
import 'package:wan_android_demo/ui/page/project/project_page.dart';
import 'package:wan_android_demo/ui/page/wechat/wechat_page.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;
  static List<String> titles = ["博文", "项目", "体系", "公众号", "我"];
  PageController _pageController;
  List<BottomNavigationBarItem> _bottomItems = [
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
    BottomNavigationBarItem(
      icon: Icon(IconF.me),
      title: Text(titles[4]),
    ),
  ];
  final List<Widget> _page = [
    BlogPage(),
    ProjectPage(),
    WeCahtPage(),
    KnowledgeSystemsPage(),
    MimePage(),
  ];

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "WanAndroid",
        theme: ThemeData(primaryColor: Colors.red),
        home: Scaffold(
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
        ));
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
