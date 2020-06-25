import 'package:flutter/material.dart';
import 'package:flutterappzeze/pages/test_page.dart';

class ExamCell extends StatefulWidget {

  final String title;       //属性/成员变量
  final String subTitle;
  final String imgName;
  final String subImgName;

  const ExamCell({           //ExamCell 的构造方法  给外界暴露的方法
    Key key,
    @required this.title,    //@required 类似于ios Protocol @required 表示必传参数
    this.subTitle,
    @required this.imgName,
    this.subImgName
  }) : super(key: key);

  @override
  _ExamCellState createState() => _ExamCellState();

}

class _ExamCellState extends State<ExamCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print("onTap");
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => TestPage(
              title: widget.title,
            )));//跳转

//        Navigator.of(context).push(MaterialPageRoute(
//          builder: (BuildContext context){
//            return TestPage(
//              title: widget.title,
//            );
//          }
//        ));
      },
      onTapDown: (TapDownDetails details){
        print("onTapDown");
      },
      onTapCancel: (){
        print("onTapCancel");
      },
      child: Container(
        padding: EdgeInsets.all(10),
        height: 54,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: [
                  Image(
                    image: AssetImage(widget.imgName), //通过widget.ivar 访问内部的成员变量(self.ivar)
                    width:20,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(widget.title),
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Text(
                    widget.subTitle != null ? widget.subTitle : '', //注意:给属性赋值是可以写逻辑判断的
                    style: TextStyle(color: Colors.grey),
                  ),
                  widget.subImgName != null ? Container(   //不为null给一个有内容的Container()
                    child: Image(
                      image: AssetImage(widget.subImgName),
                      width: 15,
                    ),
                    margin: EdgeInsets.only(left: 10,right: 10),
                  ) : Container(),
                  Image(
                    image: AssetImage('images/icon_right.png'),
                    width: 15,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
