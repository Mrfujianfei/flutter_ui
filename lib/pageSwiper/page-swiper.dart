import 'dart:async';

import 'package:demo/pageSwiper/page-dragger.dart';
import 'package:demo/pageSwiper/page-indicator.dart';
import 'package:demo/pageSwiper/page-reveal.dart';
import 'package:demo/pageSwiper/page.dart';
import 'package:flutter/material.dart';

class PageSwiper extends StatefulWidget {
  @override
  _PageSwiperState createState() => _PageSwiperState();
}

class _PageSwiperState extends State<PageSwiper> with TickerProviderStateMixin {
  StreamController<SlideUpdate> slideUpdateStream;
  AnimatedPageDragger animatedPageDragger;
  int activeIndex = 0;
  int nextPageIndex = 0;
  SlideDirection slideDirection = SlideDirection.none;
  double slidePercent = 0.0;
  _PageSwiperState() {
    slideUpdateStream = new StreamController<SlideUpdate>();
    slideUpdateStream.stream.listen((SlideUpdate event) {
      print(event.updateType);
      setState(() {
        if (event.updateType == UpdateType.dragging) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
          print('888888方向');
          print(slideDirection);

          if (slideDirection == SlideDirection.leftToRight) {
            nextPageIndex = activeIndex - 1;
          } else if (slideDirection == SlideDirection.rightToLeft) {
            nextPageIndex = activeIndex + 1;
          } else {
            nextPageIndex = activeIndex;
          }
        } else if (event.updateType == UpdateType.doneDragging) {
          print("-----------防守");
          print(slideDirection);
          if (slidePercent > 0.5) {
            animatedPageDragger = new AnimatedPageDragger(
                slideDirection: slideDirection,
                translationGoal: TransitionGoal.open,
                slidePercent: slidePercent,
                slideUpdateStream: slideUpdateStream,
                vsync: this);
          } else {
            animatedPageDragger = new AnimatedPageDragger(
                slideDirection: slideDirection,
                translationGoal: TransitionGoal.close,
                slidePercent: slidePercent,
                slideUpdateStream: slideUpdateStream,
                vsync: this);
          }
          animatedPageDragger.run();
        } else if (event.updateType == UpdateType.animating) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
        } else if (event.updateType == UpdateType.doneAnimating) {
          activeIndex = slidePercent > 0.5 ? nextPageIndex : activeIndex;
          slideDirection = SlideDirection.none;
          slidePercent = 0.0;
          animatedPageDragger.dispose();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Page(
            viewModel: pages[activeIndex],
            percentVisiable: 1.0,
          ),
          PageReveal(
            revealPercent: slidePercent,
            child: Page(
              viewModel: pages[nextPageIndex],
              percentVisiable: slidePercent,
            ),
          ),
          PageIndicator(
            viewModel: PageIndicatorViewModel(
                pages, activeIndex, slideDirection, slidePercent),
          ),
          PageDragger(
            canDragLeftToRight: activeIndex > 0,
            canDragRightToLeft: activeIndex < pages.length - 1,
            slideUpdateStream: slideUpdateStream,
          )
        ],
      ),
    );
  }
}
