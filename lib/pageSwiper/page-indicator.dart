import 'dart:ui';

import 'package:demo/pageSwiper/page.dart';
import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final PageIndicatorViewModel viewModel;
  PageIndicator({this.viewModel});

  @override
  Widget build(BuildContext context) {
    List<PageBubble> bubbles = [];
    for (var i = 0; i < viewModel.pages.length; i++) {
      final page = viewModel.pages[i];

      var percentActive;
      if (i == viewModel.activeIndex) {
        percentActive = 1.0 - viewModel.slidePercent;
      } else if (i == viewModel.activeIndex - 1 &&
          viewModel.slideDirection == SlideDirection.leftToRight) {
        percentActive = viewModel.slidePercent;
      } else if (i == viewModel.activeIndex + 1 &&
          viewModel.slideDirection == SlideDirection.rightToLeft) {
        percentActive = viewModel.slidePercent;
      } else {
        percentActive = 0.0;
      }

      bool isHollow = i > viewModel.activeIndex ||
          (i == viewModel.activeIndex &&
              viewModel.slideDirection == SlideDirection.leftToRight);

      bubbles.add(PageBubble(
        viewModel: PageBubbleViewModel(
            Icons.insert_emoticon, page.color, isHollow, percentActive),
      ));
    }

    final BUBBLE_WIDTH = 55.0;
    final baseTranslation =
        (BUBBLE_WIDTH * viewModel.pages.length) / 2 - (BUBBLE_WIDTH / 2);
    var translation = baseTranslation - BUBBLE_WIDTH * viewModel.activeIndex;
    if (viewModel.slideDirection == SlideDirection.leftToRight) {
      translation += BUBBLE_WIDTH * viewModel.slidePercent;
    } else {
      translation -= BUBBLE_WIDTH * viewModel.slidePercent;
    }
    return Transform(
      transform: Matrix4.translationValues(translation, 0.0, 0.0),
      child: Column(
        children: <Widget>[
          Expanded(child: Container()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: bubbles,
          )
        ],
      ),
    );
  }
}

class PageBubble extends StatelessWidget {
  final PageBubbleViewModel viewModel;
  PageBubble({this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55.0,
      height: 55.0,
      child: Center(
        child: Container(
          height: lerpDouble(20.0, 40.0, viewModel.activePercent),
          width: lerpDouble(20.0, 40.0, viewModel.activePercent),
          decoration: BoxDecoration(
              color: viewModel.isHollow
                  ? Colors.grey[200].withOpacity(viewModel.activePercent)
                  : Colors.grey[200],
              shape: BoxShape.circle,
              border: Border.all(
                  color: viewModel.isHollow
                      ? Colors.grey[200]
                      : Colors.grey[200]
                          .withOpacity(1.0 - viewModel.activePercent),
                  width: 3.0)),
          child: Opacity(
            opacity: viewModel.activePercent,
            child: Icon(
              viewModel.icon,
              color: viewModel.color,
            ),
          ),
        ),
      ),
    );
  }
}

enum SlideDirection { leftToRight, rightToLeft, none }

class PageIndicatorViewModel {
  final List<PageViewModel> pages;
  final int activeIndex;
  final SlideDirection slideDirection;
  final double slidePercent;
  PageIndicatorViewModel(
      this.pages, this.activeIndex, this.slideDirection, this.slidePercent);
}

class PageBubbleViewModel {
  final IconData icon;
  final Color color;
  final bool isHollow;
  final double activePercent;
  PageBubbleViewModel(this.icon, this.color, this.isHollow, this.activePercent);
}
