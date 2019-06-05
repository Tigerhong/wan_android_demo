import 'package:flutter/material.dart';
import 'package:wan_android_demo/utils/Log.dart';
import 'package:wan_android_demo/utils/NetworkUtils.dart';

typedef Future DoNetwork();

class NetworkWrapWidget extends StatefulWidget {
  DoNetwork call;

  Widget widget;

  NetworkWrapWidget({this.widget, this.call});

  @override
  State<StatefulWidget> createState() => _NetWorkState();
}

class _NetWorkState extends State<NetworkWrapWidget> {
  String TAG = "_NetWorkState";

  bool isConnet = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    checkNetwork();
  }

  void checkNetwork() async {
    Log.logT(TAG, "checkNetwork1111");
    setState(() {
      isLoading = true;
      Log.logT(TAG, "checkNetwork2222");
    });
//    await Future.delayed(Duration(seconds: 2));
    isConnet = await NetworkUtils().isConnect();
    Log.logT(TAG, "heckNetwork333  isConnet::::::$isConnet");
    if (isConnet) {
      var futrue = await widget?.call();
      Log.logT(TAG, "checkNetwork success  $futrue");
      if (futrue != null) {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
        isConnet = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Log.logT(TAG, "build build build");
    Widget returnWidget;
    if (isLoading) {
      returnWidget = getProgressView();
    } else if (!isConnet) {
      returnWidget = getNoNetworkView();
    } else {
      returnWidget = widget.widget ?? Text("暂无数据！！！");
    }
    return returnWidget;
  }

  getNoNetworkView() {
    return GestureDetector(
        onTap: () {
          if (isLoading) {
            Log.logT(TAG, "click   retrun");
            return;
          }
          checkNetwork();
        },
        child: Container(
            margin: EdgeInsets.all(20),
            child: Center(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.all(10),
                      child: Image.asset('images/no_network.png'),
                    ),
                    Text("请点击我，重新请求"),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text("网络暂无连接，请连接网络"),
                    )
                  ]),
            )));
  }

  getProgressView() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircularProgressIndicator(),
          Container(
            margin: EdgeInsets.all(10),
            child: Text("加载数据中"),
          )
        ],
      ),
    );
  }
}


