import 'package:demo/book-reader/book_model.dart';
import 'package:flutter/material.dart';

class ReaderPage extends StatefulWidget {
  int index;
  ReaderPage({this.index});
  @override
  _ReaderPageState createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage>
    with SingleTickerProviderStateMixin {
  ScrollController scroControl = new ScrollController();
  AnimationController logoControl;
  Animation logoAnimation;

  List<Book> books = [];

  @override
  void initState() {
    // TODO: implement initState
    logoControl =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    var curve =
        CurvedAnimation(parent: logoControl, curve: Curves.fastOutSlowIn);
    logoAnimation =
        Tween<Offset>(begin: Offset(0.0, -0.4), end: Offset(0.0, 0.3))
            .animate(curve);
    logoControl.forward();

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

    super.initState();
  }

  List<Widget> SliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      SliverAppBar(
        backgroundColor:Color.fromRGBO(152, 223, 243, 1),
        elevation: 0,
        centerTitle: true, //标题居中
        expandedHeight: 240.0, //展开高度200
        floating: false, //不随着滑动隐藏标题
        pinned: true, //固定在顶部
        flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.all(20),
            centerTitle: true,
            title: SlideTransition(
              position: logoAnimation,
              child: Image.asset(
                "assets/logo.png",
                color: Colors.purple,
                width: 45.0,
              ),
            ),
            background: Image.asset(books[widget.index].url, fit: BoxFit.fill)),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          controller: scroControl,
          headerSliverBuilder: SliverBuilder,
          body: ListView(
            padding: EdgeInsets.all(20.0),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  books[widget.index].title,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Text(books[widget.index].context,
                  style: TextStyle(fontSize: 14.0, letterSpacing: 2.0))
            ],
          )),
    );
  }
}
