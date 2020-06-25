import 'package:flutter/material.dart';
import 'package:flutterappzeze/root_page/app_config.dart';

class ZZIndexBar extends StatefulWidget {
  final void Function(String str) indexBarCallBack;
  const ZZIndexBar({Key key, this.indexBarCallBack}) : super(key: key);
  @override
  _ZZIndexBarState createState() => _ZZIndexBarState();
}

//根据屏幕坐标来换算获取字母索引值
int getIndex(BuildContext context,Offset localPosition){

  double y =  localPosition.dy;
  //每一个Item的高度
  var itemHeigth = ScreenHeight(context) /2 /INDEX_WORDS.length;
  //'~/'相除取整  'clamp'取值范围
  int index = (y ~/ itemHeigth).clamp(0, INDEX_WORDS.length);
  return index;
}

class _ZZIndexBarState extends State<ZZIndexBar> {
  var _selectorIndex = -1;
  double _offsetY = 0.0;
  String _indexText = 'A';
  bool _poHidden = true;

  @override
  Widget build(BuildContext context) {
    List<Widget> words = [];
    for (int i = 0; i < INDEX_WORDS.length; i++) {
      words.add(Expanded(
        child: Container(
          child: Text(
            INDEX_WORDS[i],
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ),
      ));
    }
    return Positioned(
        right: 0,
        top: ScreenHeight(context) / 8,
        height: ScreenHeight(context) / 2,
        width: 120,
        child: Row(
          children: [
            Container(
              alignment: Alignment(0.0,_offsetY),
              width: 100,
//              color: Colors.red,
              child: _poHidden == true
                  ? null
                  : Stack(
                      alignment: Alignment(-0.2, 0),  //对齐方式
                      children: [
                        Image(
                          image: AssetImage('images/ppo.png'),
                          width: 60,
                        ),
                        Text(
                          _indexText,
                          style: TextStyle(fontSize: 35, color: Colors.white),
                        )
                      ],
                    ),
            ),
            GestureDetector(
              onVerticalDragDown: (DragDownDetails details) {
                //垂直方向 touchesBegin:
                //details.globalPosition 获取当前拖动的屏幕坐标
                //details.localPosition  获取当前context的坐标
                int index = getIndex(context, details.localPosition);
                if(index != _selectorIndex){
                  _selectorIndex = index;
                  setState(() {
                    //callback 回调
                    widget.indexBarCallBack(INDEX_WORDS[index]);
                  });
                }
                //UI显示
                setState(() {
                  _indexText = INDEX_WORDS[index];
                  _offsetY = 2.2 / (INDEX_WORDS.length - 1) * index - 1.1;
                  _poHidden = false;
                });
              },
              onVerticalDragUpdate: (DragUpdateDetails details) {
                //垂直方向 touchesMove:
                print(details.localPosition);
                int index = getIndex(context, details.localPosition);
                if(index != _selectorIndex){
                  _selectorIndex = index;
                  setState(() {
                    widget.indexBarCallBack(INDEX_WORDS[index]);
                  });
                }
                //UI显示
                setState(() {
                  _indexText = INDEX_WORDS[index];
                  _offsetY = 2.2 / (INDEX_WORDS.length - 1) * index - 1.1;
                  _poHidden = false;
                });
              },
              onVerticalDragEnd: (DragEndDetails details) {
                //垂直方向 touchesEnd:
                //UI显示
                _poHidden = true;
                _selectorIndex = -1;
                setState(() {});
              },
              child: Container(
                width: 20,
                color: Color.fromRGBO(1, 1, 1, 0.3),
                child: Column(
                  children: words,
                ),
              ),
            )
          ],
        ));
  }
}

const INDEX_WORDS = [
  '🔍',
  '☆',
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];
