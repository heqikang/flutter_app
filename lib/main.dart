import 'package:flutter/material.dart';
import 'package:flutterappzeze/pages/tools/jxh_file_manager.dart';
import 'package:flutterappzeze/pages/views/jxh_web_view.dart';
import 'package:flutterappzeze/root_page/root_page.dart';
import 'package:flutterappzeze/pages/tools/jxh_file_manager.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        //取消水波纹
        highlightColor: Color.fromRGBO(1, 0, 0, 0.0),
        splashColor: Color.fromRGBO(1, 0, 0, 0.0),
      ),
      home: RootPage(),
    );
  }
}

