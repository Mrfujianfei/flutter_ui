import 'dart:async';

import 'package:demo/pageSwiper/page-indicator.dart';
import 'package:flutter/material.dart';

class PageDragger extends StatefulWidget {
  final StreamController<SlideUpdate> slideUpdateStream;
  bool canDragLeftToRight;
  bool canDragRightToLeft;
  PageDragger(
      {this.slideUpdateStream,
      this.canDragLeftToRight,
      this.canDragRightToLeft});

  @override
  _PageDraggerState createState() => _PageDraggerState();
}

class _PageDraggerState extends State<PageDragger> {
  static const FULL_TRANSLATION = 300.0;

  Offset dragStart;
  SlideDirection slideDirection;
  double slidePercent = 0.0;

  onDragStart(DragStartDetails details) {
    dragStart = details.globalPosition;
  }

  onDragUpdate(DragUpdateDetails details) {
    final newPosition = details.globalPosition;
    final dx = dragStart.dx - newPosition.dx;
    if (dx > 0 && widget.canDragRightToLeft) {
      slideDirection = SlideDirection.rightToLeft;
    } else if (dx < 0 && widget.canDragLeftToRight) {
      slideDirection = SlideDirection.leftToRight;
    } else {
      slideDirection = SlideDirection.none;
    }

    if (slideDirection != SlideDirection.none) {
      slidePercent = (dx / FULL_TRANSLATION).abs().clamp(0.0, 1.0);
    } else {
      slidePercent = 0.0;
    }
    widget.slideUpdateStream.add(
        new SlideUpdate(UpdateType.dragging, slideDirection, slidePercent));
    print('Drager $slideDirection at $slidePercent');
  }

  onDragEnd(DragEndDetails details) {
    widget.slideUpdateStream.add(
        new SlideUpdate(UpdateType.doneDragging, SlideDirection.none, 0.0));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: onDragStart,
      onHorizontalDragUpdate: onDragUpdate,
      onHorizontalDragEnd: onDragEnd,
    );
  }
}

enum UpdateType { dragging, doneDragging }

class SlideUpdate {
  final updateType;
  final direction;
  final slidePercent;
  SlideUpdate(this.updateType, this.direction, this.slidePercent);
}
