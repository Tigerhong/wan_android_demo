import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.all(10),
              child: Image.asset('images/no_data.png'),
            ),
            Text("暂无数据")
          ]),
    );
  }
}
