import 'dart:async';
import 'package:flutter/material.dart';

class AutoScrollWidgetScroller extends StatefulWidget {
  final List<Widget> items;
  final double height;
  final double itemWidth;
  final double spacing;
  final Duration scrollDelay;
  final Duration scrollDuration;

  const AutoScrollWidgetScroller({
    Key? key,
    required this.items,
    this.height = 100,
    this.itemWidth = 100,
    this.spacing = 16,
    this.scrollDelay = const Duration(seconds: 3),
    this.scrollDuration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  _AutoScrollWidgetScrollerState createState() =>
      _AutoScrollWidgetScrollerState();
}

class _AutoScrollWidgetScrollerState extends State<AutoScrollWidgetScroller> {
  final ScrollController _scrollController = ScrollController();
  late Timer _timer;

  double _currentScrollOffset = 0;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(widget.scrollDelay, (_) => _scrollToNext());
  }

  void _scrollToNext() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final nextOffset = _currentScrollOffset + widget.itemWidth + widget.spacing;

    if (nextOffset >= maxScroll) {
      _currentScrollOffset = 0;
    } else {
      _currentScrollOffset = nextOffset;
    }

    _scrollController.animateTo(
      _currentScrollOffset,
      duration: widget.scrollDuration,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.items.length,
        separatorBuilder: (_, __) => SizedBox(width: widget.spacing),
        itemBuilder: (context, index) => widget.items[index],
      ),
    );
  }
}
