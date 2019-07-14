import 'package:flutter/material.dart';

final pages = [
  new PageViewModel(
    Colors.green[300],
    'assets/pageSwiper/popsicle.png',
    '冰棍',
    '你吃过粉色的冰棍嘛？',
  ),
  new PageViewModel(
    Colors.blue[300],
    'assets/pageSwiper/pudding.png',
    '布丁',
    '卡布奇诺欧布野夫卡斯诺布丁，吃过吗？',
  ),
  new PageViewModel(
    Colors.orange,
    'assets/pageSwiper/tower.png',
    '塔可',
    '没吃过，别问了！',
  )
];

class Page extends StatelessWidget {
  final PageViewModel viewModel;
  final double percentVisiable;
  Page({this.viewModel, this.percentVisiable = 1.0});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: viewModel.color,
        child: Opacity(
          opacity: percentVisiable,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Transform(
                transform: Matrix4.translationValues(
                    0, 50.0 * (1.0 - percentVisiable), 0.0),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: Image.asset(
                    viewModel.assetsPath,
                    width: 200,
                  ),
                ),
              ),
              Transform(
                  transform: Matrix4.translationValues(
                      0, 30.0 * (1.0 - percentVisiable), 0.0),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      viewModel.title,
                      style:
                          TextStyle(fontSize: 34, fontFamily: 'FlamanteRoma'),
                    ),
                  )),
              Transform(
                  transform: Matrix4.translationValues(
                      0, 30.0 * (1.0 - percentVisiable), 0.0),
                  child: Text(
                    viewModel.body,
                    style: TextStyle(fontFamily: 'FlamanteRoma'),
                  ))
            ],
          ),
        ));
  }
}

class PageViewModel {
  final Color color;
  final String assetsPath;
  final String title;
  final String body;
  PageViewModel(this.color, this.assetsPath, this.title, this.body);
}
