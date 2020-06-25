import 'package:flutter/material.dart';
import 'package:flutterappzeze/pages/views/zz_index_bar.dart';

import 'cells/custom_cell.dart';
import 'models/friend_model.dart';

class TakenCourse extends StatefulWidget {
  @override
  _TakenCourseState createState() => _TakenCourseState();
}

class _TakenCourseState extends State<TakenCourse> with AutomaticKeepAliveClientMixin<TakenCourse> {

  ScrollController _scrollController;   //滚动控制器 ListView的委托控制器

  final List <FriendModel>_listData = [];
  final List <FriendModel>_headerData = [
    FriendModel(imageUrl: 'images/pyq.png', name: '新的朋友'),
    FriendModel(imageUrl: 'images/pyq.png', name: '群聊'),
    FriendModel(imageUrl: 'images/pyq.png', name: '标签'),
    FriendModel(imageUrl: 'images/pyq.png', name: '公众号'),
  ];
  final Map _groupOffsetMap = {
    INDEX_WORDS[0]: 0.0,
    INDEX_WORDS[1]: 0.0,
  };


  @override
  void initState() {
    super.initState();
    print('已上课程：initState() 执行了');

    //构造下数据 .. 语法糖
    _listData..addAll(datas)..addAll(datas)..sort((FriendModel a,FriendModel b){
      return a.indexLetter.compareTo(b.indexLetter);
    });
    //初始化滚动管理器
    _scrollController = ScrollController();
    //创建字母对应OffSet的Map！
    var _groupOffSet = 54.0 * 4;
    for (int i = 0; i < _listData.length; i++) {
      if (i < 1) {
        //第一个一定是头部
        _groupOffsetMap.addAll({_listData[i].indexLetter: _groupOffSet});
        _groupOffSet += 84;
      } else if (_listData[i].indexLetter == _listData[i - 1].indexLetter) {
        //如果没有头
        _groupOffSet += 54;
      } else {
        //剩下的就是有头部的了
        _groupOffsetMap.addAll({_listData[i].indexLetter: _groupOffSet});
        _groupOffSet += 84;
      }
    }

  }

  //cell复用回调
  Widget _cellForRowAtIndex(BuildContext context, int index){
    //头部cell
    if(index < _headerData.length){
      FriendModel model = _headerData[index];
      return CustomCell(
        imageAssets: model.imageUrl,
        name: model.name,
      );
    }
    //其他cell
    //如果当前model.indexLetter(对应model中的indexLetter字段)与上一个model.indexLetter相同则不显示
    //否则就显示
    if(index > 4 && _listData[index - 4].indexLetter == _listData[index - 5].indexLetter){
      //groupTitle = null
      return CustomCell(
        imageUrl: _listData[index - 4].imageUrl,
        name: _listData[index - 4].name,
      );
    }

    return CustomCell(
      imageUrl: _listData[index - 4].imageUrl,
      name: _listData[index - 4].name,
      groupTitle: _listData[index - 4].indexLetter,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('已上课程'),
//        leading: Text('我是左边'),
        actions: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(Icons.add),
            ),
            onTap: (){
//              print('我被点击了');
//              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
//                return AddFriend(
//                  cellName: '泽泽伐木类',
//                );
//              }));
            },
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            ListView.builder(  //具备复用能力的ListView()
              itemCount: _headerData.length+_listData.length,
              itemBuilder: _cellForRowAtIndex,
              controller: _scrollController, //给ListView设置一个委托控制器(ScrollController),间接操作滚动行为等
            ),
            ZZIndexBar(
              indexBarCallBack: (String str){
                //这里响应后 我们通过Str换算出ListView需要偏移的位置
                //并通过ScrollController来间接操作ListView的滚动行为
                print('====='+str);
                //_groupOffsetMap 维护了一个根据str找到具体的offset值的Map 就不赘述了
                if (_groupOffsetMap[str] != null) {
                  //animateTo()来发生滚动偏移
                  _scrollController.animateTo(
                    _groupOffsetMap[str],   //偏移的值
                    duration: Duration(milliseconds: 10), //动画持续时长
                    curve: Curves.easeIn,  //动效执行曲线
                  );
                }
              },
            )
          ],
        )
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
