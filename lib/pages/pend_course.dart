// 待上课程
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:http/http.dart' as Http;

class PendCourse extends StatefulWidget {
  @override
  _PendCourseState createState() => _PendCourseState();
}

//在Flutter简单的 json <=> model
void jsonModel() {
  //测试数据
  final testMap = {
    'iconUrl': 'http://zezefamily/hello_flutter',
    'userName': 'zezefamily',
    'useDes': '泽泽是个好人',
  };
  //Map(NSDictionary) 转 json
  final jsonStr = json.encode(testMap);
  print(jsonStr);
  //json 转 Map
  final jsonMap = json.decode(jsonStr);
  print(jsonMap['userName']);
  //Map 转 Model
  ChatUser model = ChatUser.fromJson(jsonMap);
  print(model.userName);
}

class _PendCourseState extends State<PendCourse> with AutomaticKeepAliveClientMixin<PendCourse>{
  List<ChatUser> _datas = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('待上课程：initState() 执行了');

    //发起数据
    getData()
        .then((List<ChatUser> datas) {
//          print(datas);
          setState(() {
            _datas = datas;
          });
        })
        .catchError((error) {
          print('错误信息:$error');
        })
        .whenComplete(() {
          print('本次请求完成');
        })
        .timeout(Duration(seconds: 6))
        .catchError((timeoutError) {
          print('请求超时；$timeoutError');
        });
  }

  // func: 请求网络数据
  Future<List<ChatUser>> getData() async {
    //发起get请求
    final response =
        await Http.get('http://rap2.taobao.org:38080/app/mock/data/1624211');
    if (response.statusCode == 200) {
      //获取响应数据并转为Map
      final respBody = json.decode(response.body);
      List<ChatUser> list = respBody['user_list'].map<ChatUser>((item) {
        return ChatUser.fromJson(item);
      }).toList();
      return list;
    } else {
      throw Exception('errorCode:${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('待上课程'),
        ),
        body: Container(
          child: _datas.length == 0
              ? Center(
                  child: Text('数据加载中...'),
                )
              : ListView.builder(
                  itemCount: _datas.length,
                  itemBuilder: (BuildContext context,int index){
                    return ListTile(
                      title: Text(_datas[index].userName),
                      subtitle: Text(_datas[index].useDes),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(_datas[index].iconUrl),
                      ),
                    );
                  },
               ),
        ));
  }


}

class ChatUser {

  final String iconUrl;
  final String userName;
  final String useDes;

  ChatUser({this.iconUrl, this.userName, this.useDes});

  factory ChatUser.fromJson(Map json) {
    return ChatUser(
      iconUrl: json['icon_url'],
      userName: json['user_name'],
      useDes: json['use_des'],
    );
  }

}

/*
* {
      "icon_url": "https://randomuser.me/api/portraits/men/37.jpg",
      "user_name": "任秀英",
      "use_des": "东了确月花口都上亲边建元应。龙即平用高阶眼就太能回电包第变。点半多切对物技传先影应声然系名。"
    },
* */
