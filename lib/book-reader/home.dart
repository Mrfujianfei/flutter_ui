import 'package:demo/book-reader/book_model.dart';
import 'package:demo/book-reader/custome_router.dart';
import 'package:demo/book-reader/read.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePageDemo extends StatefulWidget {
  @override
  _HomePageDemoState createState() => _HomePageDemoState();
}

class _HomePageDemoState extends State<HomePageDemo>
    with TickerProviderStateMixin {
  AnimationController buttonControl;
  Animation<double> buttonAnimation;

  AnimationController logoControl;
  Animation<Offset> logoAnimation;

  AnimationController containerControl;
  Animation<Offset> containerAnimation;

  AnimationController swiperControl;
  Animation<Offset> swiperAnimation;

  AnimationController cardControl;
  Animation<double> cardAnimation;

  List books = [];
  double contextHeight = 0.0;
  int swiperIndex = 0;

  @override
  void initState() {
    books
      ..add(Book(
          url: "assets/card3.jpg",
          title: "付先生，余生请指教",
          desc: "天气依然阴冷,风也大,她今天穿得比较少,不像昨天一样全副武装,所以一下车就情不自禁打了个冷战。",
          context:
              "东西都带齐全了吗? 徐霆舟问她。她轻轻点头,双手却不自觉紧紧抓住手提包的带子,神情局促不安。徐霆舟注意到了,抬腕看了眼时间,离民政局下班还有五十分钟,于是拉过戚星的手走向他的座驾。上车后,他发动车子开足暖气,这才对戚星说: 如果你不想领这个证,可以拒绝。他语气平和,却是一贯的平淡,让人听不出喜怒。戚星垂眸敛眼,过了好一会儿才抬起头来望着徐霆舟,一双杏眸写满了不安和迟疑。她说: 我不是不想,只是事情太突然,我还没做好心理准备。而且,我不知道你为什么突然做这样的决定。这个男人虽然经常做些不按常理出牌的事,但这次真的太突然了,她连静下来思考的时间都没有,就只是机械地回家换衣服、化妆、拿身份证和户口本,匆匆忙忙,有种赶鸭子上架的被动感。你觉得太突然了没有安全感? 徐霆舟一语道破她的顾虑,直直地看着她,随后从大衣口袋里掏出一个精致的首饰盒。"))
      ..add(Book(
          url: "assets/card2.jpg",
          title: "灼焰声声",
          desc: "天气依然阴冷,风也大,她今天穿得比较少,不像昨天一样全副武装,所以一下车就情不自禁打了个冷战。",
          context:
              "东西都带齐全了吗? 徐霆舟问她。她轻轻点头,双手却不自觉紧紧抓住手提包的带子,神情局促不安。徐霆舟注意到了,抬腕看了眼时间,离民政局下班还有五十分钟,于是拉过戚星的手走向他的座驾。上车后,他发动车子开足暖气,这才对戚星说: 如果你不想领这个证,可以拒绝。他语气平和,却是一贯的平淡,让人听不出喜怒。戚星垂眸敛眼,过了好一会儿才抬起头来望着徐霆舟,一双杏眸写满了不安和迟疑。她说: 我不是不想,只是事情太突然,我还没做好心理准备。而且,我不知道你为什么突然做这样的决定。这个男人虽然经常做些不按常理出牌的事,但这次真的太突然了,她连静下来思考的时间都没有,就只是机械地回家换衣服、化妆、拿身份证和户口本,匆匆忙忙,有种赶鸭子上架的被动感。你觉得太突然了没有安全感? 徐霆舟一语道破她的顾虑,直直地看着她,随后从大衣口袋里掏出一个精致的首饰盒。"))
      ..add(Book(
          url: "assets/card1.jpg",
          title: "嘘，有熊出没",
          desc: "天气依然阴冷,风也大,她今天穿得比较少,不像昨天一样全副武装,所以一下车就情不自禁打了个冷战。",
          context:
              "东西都带齐全了吗? 徐霆舟问她。她轻轻点头,双手却不自觉紧紧抓住手提包的带子,神情局促不安。徐霆舟注意到了,抬腕看了眼时间,离民政局下班还有五十分钟,于是拉过戚星的手走向他的座驾。上车后,他发动车子开足暖气,这才对戚星说: 如果你不想领这个证,可以拒绝。他语气平和,却是一贯的平淡,让人听不出喜怒。戚星垂眸敛眼,过了好一会儿才抬起头来望着徐霆舟,一双杏眸写满了不安和迟疑。她说: 我不是不想,只是事情太突然,我还没做好心理准备。而且,我不知道你为什么突然做这样的决定。这个男人虽然经常做些不按常理出牌的事,但这次真的太突然了,她连静下来思考的时间都没有,就只是机械地回家换衣服、化妆、拿身份证和户口本,匆匆忙忙,有种赶鸭子上架的被动感。你觉得太突然了没有安全感? 徐霆舟一语道破她的顾虑,直直地看着她,随后从大衣口袋里掏出一个精致的首饰盒。"));

    buttonControl =
        AnimationController(vsync: this, duration: Duration(milliseconds: 900));
    buttonAnimation = Tween(begin: 1.0, end: 0.0).animate(buttonControl);

    logoControl =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    CurvedAnimation logoCurve =
        CurvedAnimation(parent: logoControl, curve: Curves.fastOutSlowIn);
    logoAnimation = Tween(begin: Offset(0.0, 0.0), end: Offset(0.0, -1.2))
        .animate(logoCurve);

    containerControl = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    CurvedAnimation containerCurve =
        CurvedAnimation(parent: containerControl, curve: Curves.fastOutSlowIn);
    containerAnimation = Tween(begin: Offset(0.0, 0.0), end: Offset(0.0, -1.0))
        .animate(containerCurve);

    swiperControl =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    CurvedAnimation swiperCurve =
        CurvedAnimation(parent: swiperControl, curve: Curves.fastOutSlowIn);
    swiperAnimation = Tween(begin: Offset(0.0, 0.0), end: Offset(-1.0, 0.0))
        .animate(swiperCurve);

    cardControl =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    CurvedAnimation cardCurve =
        CurvedAnimation(parent: cardControl, curve: Curves.linear);
    cardAnimation = Tween(begin: 1.0, end: 1.75).animate(cardCurve);
    super.initState();
  }

  Widget Button(width) {
    return Positioned(
        top: 280,
        left: width / 2 - 40,
        child: FadeTransition(
            opacity: buttonAnimation,
            child: FlatButton(
              onPressed: () {
                Future.delayed(Duration(milliseconds: 300)).then((value) {
                  logoControl.forward();
                  swiperControl.forward();
                });
                buttonControl.forward();
                setState(() {
                  contextHeight = 400.0;
                });
              },
              color: Colors.purple,
              child: Text(
                "开启阅读",
                style: TextStyle(color: Colors.white),
              ),
            )));
  }

  Widget ContainerBox(width) {
    return Positioned(
        bottom: 0,
        child: AnimatedContainer(
          padding: EdgeInsets.only(top: 10.0),
          decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25.0),
                  topLeft: Radius.circular(25.0))),
          height: contextHeight,
          width: width,
          duration: Duration(milliseconds: 1000),
          curve: Curves.fastOutSlowIn,
          child: Text(
            "Love you three thousand times",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ));
  }

  Widget BookCard(index) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, .2),
                  blurRadius: 5.0,
                  offset: Offset(0.0, 8.0)),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 150,
                  width: double.maxFinite,
                  child: Image.asset(
                    books[index].url,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(books[index].title,
                            style: TextStyle(fontSize: 16.0)),
                      ),
                      Text(
                        books[index].desc,
                        style: TextStyle(fontSize: 12.0),
                        textAlign: TextAlign.justify,
                      ),
                      Container(
                        height: 30.0,
                        margin: EdgeInsets.only(top: 20.0),
                        decoration: new BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              Color.fromRGBO(94, 134, 203, 1),
                              Color.fromRGBO(90, 34, 195, 1),
                            ]),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            cardControl.forward();
                            logoControl.reverse();
                            setState(() {
                              contextHeight = 520.0;
                            });
                            Future.delayed(Duration(milliseconds: 300))
                                .then((value) {
                              Navigator.of(context)
                                  .push(CustomRoute(ReaderPage(
                                index: index,
                              )))
                                  .then((value) {
                                Future.delayed(Duration(milliseconds: 100))
                                    .then((value) {
                                  setState(() {
                                    contextHeight = 400.0;
                                  });
                                  cardControl.reverse();
                                  logoControl.forward();
                                });
                              });
                            });
                          },
                          child: Text(
                            "Read",
                            style: TextStyle(letterSpacing: 1.0,color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget BookBox(width) {
    return Positioned(
        bottom: 0,
        left: width,
        child: SlideTransition(
            position: swiperAnimation,
            child: ScaleTransition(
                alignment: Alignment.bottomCenter,
                scale: cardAnimation,
                child: Container(
                  height: 360,
                  color: Colors.white,
                  width: width,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return BookCard(index);
                    },
                    index: swiperIndex,
                    itemCount: 3,
                    viewportFraction: 0.7,
                    scale: 1.0,
                    // loop: false,
                    // outer: false,
                    onIndexChanged: (index) {
                      setState(() {
                        swiperIndex = index;
                      });
                    },
                  ),
                ))

            //  AnimatedContainer(
            //   duration: Duration(milliseconds: 800),
            //   curve: Curves.fastOutSlowIn,
            //   color: Colors.white,
            //   height: cardBoxHeight ?? 360,
            //   width: width,
            //   child:
            // ),
            ));
  }

  Widget Logo(width) {
    return Positioned(
        top: 180.0,
        left: width / 2 - 42,
        child: SlideTransition(
          position: logoAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                color: Colors.white,
                iconSize: 70,
                onPressed: () {
                  Future.delayed(Duration(milliseconds: 200)).then((value) {
                    logoControl.reverse();

                    buttonControl.reverse();
                  });
                  swiperControl.reverse();
                  // containerControl.reverse();
                  // cardControl.reverse();
                  setState(() {
                    contextHeight = 0.0;
                  });
                  cardControl.reverse();
                },
                icon: Image.asset("assets/logo.png", color: Colors.purple),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg.png"), fit: BoxFit.fill)),
      child: Stack(
        children: <Widget>[
          Button(width),
          ContainerBox(width),
          BookBox(width),
          Logo(width)
        ],
      ),
    ));
  }
}
