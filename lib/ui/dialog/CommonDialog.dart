import 'package:flutter/material.dart';
import 'package:wan_android_demo/common/GlobalConfig.dart';

class CommonDialog {
  static void show(
    BuildContext context,
    List<String> titles,
    ValueChanged<int> call, {
    width = 250.0,
    List<Color> colors,
    int selectIndex=-1,
  }) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              padding: new EdgeInsets.all(4.0),
              margin: new EdgeInsets.all(20.0),
              decoration: new BoxDecoration(
                color: Colors.white,
                //用一个BoxDecoration装饰器提供背景图片
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              width: width,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  return RaisedButton(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.black,
                            width: 2,
                            style: selectIndex == index
                                ? BorderStyle.solid
                                : BorderStyle.none),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    padding: new EdgeInsets.only(
                        left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
                    textColor: Colors.white,
                    color: (colors ?? GlobalConfig.getThemeListColor())[index],
                    child: Text(titles[index]),
                    onPressed: () {
                      call(index);
                    },
                  );
                },
              ),
            ),
          );
        });
  }
}
