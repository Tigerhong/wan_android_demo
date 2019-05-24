import 'package:flutter/material.dart';
import 'package:wan_android_demo/common/GlobalConfig.dart';
import 'package:wan_android_demo/common/Sp.dart';
import 'package:wan_android_demo/state/scoped/ThemeModel.dart';

class ThemeSelectDialog {
  ///
  static void show(BuildContext context,
      {width = 250.0, height = 400.0, VoidCallback okCallback}) {
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
              height: height,
              child: ListView.builder(
                itemCount: GlobalConfig.getThemeListTitle.length,
                itemBuilder: (context, index) {
                  return RaisedButton(
                    padding: new EdgeInsets.only(
                        left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
                    textColor: Colors.white,
                    color: GlobalConfig.getThemeListColor()[index],
                    child: Text(GlobalConfig.getThemeListTitle[index]),
                    onPressed: () {
                      ThemeModel.of(context).setIndex(index);
                      Sp.put(SpConsKy.key_theme, "$index");
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
          );
        });
  }
}
