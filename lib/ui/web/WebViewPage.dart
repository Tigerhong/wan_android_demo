import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatefulWidget {
  String title;
  String url;

  WebViewPage({this.title, this.url});

  @override
  State<StatefulWidget> createState() => _WebViewState();
}

class _WebViewState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
        url: widget.url,
        appBar: new AppBar(
          title: new Text(widget.title),
        ));
  }
}
