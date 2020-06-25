import 'package:flutter/material.dart';
import 'package:flutterappzeze/pages/exam_page.dart';
import 'package:flutterappzeze/pages/pend_course.dart';
import 'package:flutterappzeze/pages/personal_page.dart';
import 'package:flutterappzeze/pages/taken_course.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {


  int _currentIndex = 0;

  // ViewControllers
  List <Widget> _viewControllers = [
    PendCourse(),       //待上课程
    TakenCourse(),      //已上课程
    ExamPage(),         //水平测试
    PersonalPage(),     //我
  ];
  // tabBarItems
  List <BottomNavigationBarItem> _tabBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.access_alarm),
      title: Text('待上课程')
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.history),
      title: Text('已上课程')
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.perm_camera_mic),
      title: Text('水平测试')
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('我')
    ),
  ];

  final PageController _controller = PageController(
    initialPage: 0,  //默认显示第0个页面
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index){
            _currentIndex = index;
            setState(() {});
            _controller.jumpToPage(index);
          },
          selectedFontSize: 12.0,
          type:BottomNavigationBarType.fixed,
          fixedColor: Colors.green,
          currentIndex: _currentIndex,
          items: _tabBarItems,
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          //AlwaysScrollableScrollPhysics(),  默认方式
          //NeverScrollableScrollPhysics(),
          controller: _controller,
          children: _viewControllers,
        ),
      ),
    );
  }
}
