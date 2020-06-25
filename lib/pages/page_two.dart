import 'package:flutter/material.dart';

import 'cells/custom_cell.dart';
import 'models/friend_model.dart';


class PageTwo extends StatefulWidget {
  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {

  final List <FriendModel>_listData = [];
  final List <FriendModel>_headerData = [
    FriendModel(imageUrl: 'images/new_friend.png', name: '新的朋友'),
    FriendModel(imageUrl: 'images/new_friend.png', name: '群聊'),
    FriendModel(imageUrl: 'images/new_friend.png', name: '标签'),
    FriendModel(imageUrl: 'images/new_friend.png', name: '公众号'),
  ];

  @override
  void initState() {
    super.initState();
    //构造下数据 .. 语法糖
    _listData..addAll(datas)..addAll(datas)..sort((FriendModel a,FriendModel b){
      return a.indexLetter.compareTo(b.indexLetter);
    });
//    //按照字母进行排序 跟NSArray类似
//    _listData.sort((FriendModel a,FriendModel b){
//      return a.indexLetter.compareTo(b.indexLetter);
//    });
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
        title: Text('泽泽2'),
        actions: <Widget>[
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
        child: ListView.builder(  //具备复用能力的ListView()
          itemCount: _headerData.length+_listData.length,
          itemBuilder: _cellForRowAtIndex,
      ),
      ),
    );
  }
}
