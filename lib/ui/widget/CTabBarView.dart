import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wan_android_demo/utils/Log.dart';

class CTabBarView extends StatefulWidget {
  /// Creates a page view with one child per tab.
  ///
  /// The length of [children] must be the same as the [controller]'s length.
  const CTabBarView({
    Key key,
    @required this.children,
    this.controller,
    this.physics,
    this.dragStartBehavior = DragStartBehavior.down,
  })  : assert(children != null),
        assert(dragStartBehavior != null),
        super(key: key);

  /// This widget's selection and animation state.
  ///
  /// If [TabController] is not provided, then the value of [DefaultTabController.of]
  /// will be used.
  final TabController controller;

  /// One widget per tab.
  final List<Widget> children;

  /// How the page view should respond to user input.
  ///
  /// For example, determines how the page view continues to animate after the
  /// user stops dragging the page view.
  ///
  /// The physics are modified to snap to page boundaries using
  /// [PageScrollPhysics] prior to being used.
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics physics;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  @override
  _TabBarViewState createState() => _TabBarViewState();
}

final PageScrollPhysics _kTabBarViewPhysics =
    const PageScrollPhysics().applyTo(const ClampingScrollPhysics());

class _TabBarViewState extends State<CTabBarView> {
  String TAG = "_TabBarViewState";
  TabController _controller;
  PageController _pageController;
  List<Widget> _children;
  int _currentIndex;
  int _warpUnderwayCount = 0;

  void _updateTabController() {
    final TabController newController =
        widget.controller ?? DefaultTabController.of(context);
    assert(() {
      if (newController == null) {
        throw FlutterError('No TabController for ${widget.runtimeType}.\n'
            'When creating a ${widget.runtimeType}, you must either provide an explicit '
            'TabController using the "controller" property, or you must ensure that there '
            'is a DefaultTabController above the ${widget.runtimeType}.\n'
            'In this case, there was neither an explicit controller nor a default controller.');
      }
      return true;
    }());
    if (newController == _controller) return;

    if (_controller != null)
      _controller.animation.removeListener(_handleTabControllerAnimationTick);
    _controller = newController;
    if (_controller != null)
      _controller.animation.addListener(_handleTabControllerAnimationTick);
  }

  @override
  void initState() {
    super.initState();
    _children = widget.children;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTabController();
    _currentIndex = _controller?.index;
    _pageController = PageController(initialPage: _currentIndex ?? 0);
  }

  @override
  void didUpdateWidget(CTabBarView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) _updateTabController();
    if (widget.children != oldWidget.children && _warpUnderwayCount == 0)
      _children = widget.children;
  }

  @override
  void dispose() {
    if (_controller != null)
      _controller.animation.removeListener(_handleTabControllerAnimationTick);
    // We don't own the _controller Animation, so it's not disposed here.
    super.dispose();
  }

  void _handleTabControllerAnimationTick() {
    if (_warpUnderwayCount > 0 || !_controller.indexIsChanging)
      return; // This widget is driving the controller's animation.

    if (_controller.index != _currentIndex) {
      _currentIndex = _controller.index;
      _warpToCurrentIndex();
    }
  }

  Future<void> _warpToCurrentIndex() async {
    if (!mounted) return Future<void>.value();

    if (_pageController.page == _currentIndex.toDouble())
      return Future<void>.value();

    final int previousIndex = _controller.previousIndex;
    if ((_currentIndex - previousIndex).abs() == 1)
      return _pageController.animateToPage(_currentIndex,
          duration: kTabScrollDuration, curve: Curves.ease);

    assert((_currentIndex - previousIndex).abs() > 1);
    int initialPage;
    setState(() {
      _warpUnderwayCount += 1;
      _children = List<Widget>.from(widget.children, growable: false);
      if (_currentIndex > previousIndex) {
        _children[_currentIndex - 1] = _children[previousIndex];
        initialPage = _currentIndex - 1;
      } else {
        _children[_currentIndex + 1] = _children[previousIndex];
        initialPage = _currentIndex + 1;
      }
    });

    _pageController.jumpToPage(initialPage);

    await _pageController.animateToPage(_currentIndex,
        duration: kTabScrollDuration, curve: Curves.ease);
    if (!mounted) return Future<void>.value();

    setState(() {
      _warpUnderwayCount -= 1;
      _children = widget.children;
    });
  }

  // Called when the PageView scrolls
  bool _handleScrollNotification(ScrollNotification notification) {
    Log.logT(TAG,
        "_handleScrollNotification1  _warpUnderwayCount:$_warpUnderwayCount   depth:${notification.depth}");
    if (_warpUnderwayCount > 0) return false;
    Log.logT(TAG,
        "_handleScrollNotification2  _warpUnderwayCount:$_warpUnderwayCount   depth:${notification.depth}");
    if (notification.depth != 0) {
//      _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
      return false;
    }
    Log.logT(TAG,
        "_handleScrollNotification3  _warpUnderwayCount:$_warpUnderwayCount   depth:${notification.depth}");
    _warpUnderwayCount += 1;
    if (notification is ScrollUpdateNotification &&
        !_controller.indexIsChanging) {
      Log.logT(TAG,
          "_handleScrollNotification4  offset${_pageController.page - _controller.index}  _pageController.page${_pageController.page} _controller.index${_controller.index}");
      if ((_pageController.page - _controller.index).abs() > 1.0) {
        Log.logT(TAG, "_handleScrollNotification41");
        _controller.index = _pageController.page.floor();
        _currentIndex = _controller.index;
      }
      Log.logT(TAG, "_handleScrollNotification42");
      _controller.offset =
          (_pageController.page - _controller.index).clamp(-1.0, 1.0);
      Log.logT(TAG,
          "_handleScrollNotification43  offset${_pageController.page - _controller.index}  pageController.page${_pageController.page} _controller.index${_controller.index}");
    } else if (notification is ScrollEndNotification) {
      Log.logT(TAG, "_handleScrollNotification5");
      _controller.index = _pageController.page.round();
      _currentIndex = _controller.index;
    }
    _warpUnderwayCount -= 1;

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: PageView(
          dragStartBehavior: widget.dragStartBehavior,
          controller: _pageController,
          physics: widget.physics == null
              ? _kTabBarViewPhysics
              : _kTabBarViewPhysics.applyTo(widget.physics),
          children: _children,
        ));
  }
}
