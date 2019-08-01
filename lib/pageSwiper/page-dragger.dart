import 'dart:async';
import 'dart:ui';

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

class AnimatedPageDragger {
  static const PERCENT_PER_MILLISECOND = 0.005;

  final slideDirection;
  final translationGoal;

  AnimationController completionAnimationController;

  AnimatedPageDragger({
    this.slideDirection,
    this.translationGoal,
    slidePercent,
    StreamController<SlideUpdate> slideUpdateStream,
    TickerProvider vsync,
  }) {
    var startSlidePercent = slidePercent;
    var endSlidePercent;

    var duration;

    if (translationGoal == TransitionGoal.open) {
      endSlidePercent = 1.0;
      final slideRemaing = 1.0 - slidePercent;
      duration = Duration(
          milliseconds: (slideRemaing / PERCENT_PER_MILLISECOND).round());
    } else {
      endSlidePercent = 0.0;
      duration = Duration(
          milliseconds: (slidePercent / PERCENT_PER_MILLISECOND).round());
    }
    // print("****$slidePercent*****");
    // print("****$PERCENT_PER_MILLISECOND*****");
    // print("****$startSlidePercent*****");
    // print("****$endSlidePercent*****");
    // print("****$duration*****");
    completionAnimationController = new AnimationController(
      duration: duration,
      vsync: vsync,
    )
    ..addListener(() {
        final aslidePercent = lerpDouble(startSlidePercent, endSlidePercent,
            completionAnimationController.value);
        slideUpdateStream.add(new SlideUpdate(
          UpdateType.animating,
          slideDirection,
          aslidePercent,
        ));
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          slideUpdateStream.add(SlideUpdate(
              UpdateType.doneAnimating, slideDirection, endSlidePercent));
        }
      });
  }

  run() {
    completionAnimationController.forward(from: 0.0);
  }

  dispose() {
    completionAnimationController.dispose();
  }
}

enum TransitionGoal { open, close }

enum UpdateType { dragging, doneDragging, animating, doneAnimating }

class SlideUpdate {
  final updateType;
  final direction;
  final slidePercent;
  SlideUpdate(this.updateType, this.direction, this.slidePercent);
}
