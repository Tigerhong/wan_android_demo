import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity/connectivity.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    isConnect();
  }

  bool isConnectB = false;

  Future<int> getNetWorkState() async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile)
      return 1;
    else if (connectivityResult == ConnectivityResult.wifi)
      return 2;
    else if (connectivityResult == ConnectivityResult.none) return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(child: Text('Connection Status:isConnect:::$isConnectB}')),
      floatingActionButton: FloatingActionButton(onPressed: isConnect),
    );
  }

  void isConnect() async {
    var netWorkState = await getNetWorkState();
    if (netWorkState == 0) {
      isConnectB = false;
    } else {
      isConnectB = true;
    }
    print("isConnect::::$isConnectB state::::$netWorkState");
    setState(() {

    });
  }
}
