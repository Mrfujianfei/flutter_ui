import 'package:demo/book-reader/home.dart';
import 'package:demo/carouse-list/carousel-list.dart';
import 'package:demo/page-swiper/page-swiper.dart';
import 'package:flutter/material.dart';

import 'animation-wall/animation-wall.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "flutter demo",
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(primarySwatch: Colors.lightGreen),
        home: CarouseList(),
        // home: HomePageDemo(),
        // home: PageSwiper()
        // home: AnimationWall()
        );
  }
}
