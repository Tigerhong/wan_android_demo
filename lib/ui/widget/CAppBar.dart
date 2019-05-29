import 'package:flutter/material.dart';
import 'package:wan_android_demo/fonts/IconF.dart';
import 'package:provider/provider.dart';
import 'package:wan_android_demo/state/provide/OpenDrawerWidget.dart';

// ignore: must_be_immutable
class CAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  final PreferredSizeWidget bottom;

  final Size preferredSize;

  CAppBar({this.title, this.bottom})
      : preferredSize = Size.fromHeight(
            kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(IconF.search),
        )
      ],
      title: Text(title, style: Theme.of(context).primaryTextTheme.title),
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
        Provider.of<OpenDrawerhWidget>(context).refresh();
        },
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      ),
      bottom: bottom,
    );
  }
}
