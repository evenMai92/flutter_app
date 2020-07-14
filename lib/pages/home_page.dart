import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
const APPBAR_SCROLL_OFFSET = 100;
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    'https://dimg04.c-ctrip.com/images/0zg7312000479inso75B4.jpg',
    'https://dimg07.c-ctrip.com/images/100e0h0000008rp39A12F_C_750_375.jpg',
    'https://dimg04.c-ctrip.com/images/0zg3j120004va7ebq7783.jpg'
  ];
  double appBarAlpha = 0;
  // 设置页面滚动时相关容器的透明度
  void _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if(alpha < 0) {
      alpha = 0;
    } else if(alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Stack为重叠Widget
      body: Stack(
        children: <Widget>[
          // 移除相关的padding(用了ListView之后会有padding)
          MediaQuery.removePadding(
              removeTop: true,
              context: context,
              // NotificationListener监听内容滚动
              child: NotificationListener(
                // 滚动事件 scrollNotification为滚动距离
                onNotification: (scrollNotification) {
                  if(scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0) {
                    // 滚动且是列表滚动的时候
                    _onScroll(scrollNotification.metrics.pixels);
                    return true;
                  }
                  return false;
                },
                // 列表滚动
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 160,
                      child: new Swiper(
                        itemCount: _imageUrls.length,
                        autoplay: true,
                        // 当前项数据
                        itemBuilder: (BuildContext context, int index) {
                          return new Image.network(
                            _imageUrls[index],
                            fit: BoxFit.fill,
                          );
                        },
                        // 小点
                        pagination: new SwiperPagination(
                            builder: new DotSwiperPaginationBuilder(
                                color: Colors.white,
                                size: 8.0,
                                activeSize: 10.0
                            )
                        ),
                      ),
                    ),
                    Container(
                      height: 800,
                      child: ListTile(title: Text('哈哈'),),
                    )
                  ],
                ),
              )
          ),
          // 设置透明
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('首页'),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}