import 'package:flutter/material.dart';
import 'package:wan_android_demo/ui/widget/NetworkWrapWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _App();
}

class _App extends State<MyApp> {
  bool isShowData = false;

  @override
  void initState() {
    super.initState();
  }

  Future getData() async {
    return await Future.delayed(Duration(seconds: 5), () {
      setState(() {
        print("MyApp   geData success");
        isShowData = true;
      });
      return Future.value(true);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          body: Container(
        child: Center(
          child: NetworkWrapWidget(
            widget: Text("hello"),
            call: getData,
          ),
        ),
      )),
    );
  }
}


