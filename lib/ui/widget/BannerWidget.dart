import 'package:flutter/material.dart';
import 'dart:ui' as ui;
///banner组件
class BannerWidget extends StatefulWidget {
  List<Widget> itemPage;

  BannerWidget({Key key, this.itemPage}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return getContent();
  }

  getContent() {
    double screenWidth = MediaQueryData.fromWindow(ui.window).size.width;
//    double screenHeight = MediaQueryData.fromWindow(ui.window).size.height;
    double bannerHeight = screenWidth / 2;
    double indicatorHeight = bannerHeight / 6;
    return Container(
      width: screenWidth,
      height: bannerHeight,
      child: Stack(
        children: <Widget>[
          PageView(
            onPageChanged: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: widget.itemPage,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.center,
              height: indicatorHeight,
              color: Color.fromARGB(30, 0, 0, 0),
              child: ListView.separated(
                  separatorBuilder: _separatorBuilder,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.itemPage.length,
                  itemBuilder: _indicatorItemBuilder),
            ),
          )
        ],
      ),
    );
  }

  ///指示器item创建者
  Widget _indicatorItemBuilder(BuildContext context, int index) {
    return CircleAvatar(
      radius: 8,
      backgroundColor:
          _currentIndex == index ? Colors.yellow : Color.fromARGB(80, 0, 0, 0),
    );
  }

  ///divider创建者
  Widget _separatorBuilder(BuildContext context, int index) {
    return Divider(
      indent: 5,
    );
  }
}
