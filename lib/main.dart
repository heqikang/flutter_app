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

//import 'dart:typed_data';
//void main() {
//  int offset = 0;
//  ByteData data = ByteData(4+20);
//  data.setInt32(offset,20);
//  offset+=4;
//  data.setUint16(offset,201);
//  offset+=2;
//  print(data);
//  ByteBuffer buffer = data.buffer;
//  print(buffer);
//  Uint8List list =  buffer.asUint8List(0,data.lengthInBytes);
//  List<int> list2 = List()..addAll(list);
//  print(list);
//  print(list2);
////   list2.fillRange(0,6,[]);
////   list2.replaceRange(0,6,[]);
//  print(list2);
//  Uint8List uint8List = Uint8List.fromList(list2);
//  print(uint8List);
////   ByteData data2 = ByteData(list2.length);
//  ByteData data2 = ByteData.sublistView(uint8List);
//  int length = data2.getInt32(0);
//  print("length == $length");
//  print("uint8List.lengthInBytes == ${uint8List.lengthInBytes}");
//  print("uint8List.length == ${uint8List.length}");
//  print("data2.lengthInBytes == ${data2.lengthInBytes}");
//}


