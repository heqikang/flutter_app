import 'package:flutter/material.dart';
import 'package:flutterappzeze/root_page/app_config.dart';


class CustomCell extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String groupTitle;
  final String imageAssets;

  const CustomCell({
    Key key,
    this.imageUrl,
    this.name,
    this.groupTitle,
    this.imageAssets,
  }) : super(key: key);

  @override
  _CustomCellState createState() => _CustomCellState();
}

class _CustomCellState extends State<CustomCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10),
            height: widget.groupTitle != null ? 30 : 0,
            color: Color.fromRGBO(236, 237, 237, 1.0),
//            child: Text(widget.groupTitle,style: TextStyle(color: Colors.white),),
            child: widget.groupTitle != null ? Text(widget.groupTitle,style: TextStyle(color: Color.fromRGBO(76, 75, 75, 1.0),),):null,
          ),//SectionHeader
          Container(
            height: 54,
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  width:34,
                  height: 34,
                  margin: EdgeInsets.all(10),
                  //设置圆角
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    image: DecorationImage(
                        image:widget.imageUrl != null ? NetworkImage(widget.imageUrl) : AssetImage(widget.imageAssets),
                    ),
                  ),
                ), //左图
                Container(
//                  color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, //上下对齐
                    children: [
                      Container(  //昵称
//                        color: Colors.red,
                        height:53.5,
                        width: ScreenWidth(context) - 10 - 10 - 34,
                        alignment: Alignment.centerLeft,  //文本对齐
                        child: Text(
                          widget.name,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Container(  //线
                         height: 0.5,
                         width: ScreenWidth(context) - 10 - 10 - 34,
                         color: Color.fromRGBO(246, 246, 246, 1.0),

                      )
                    ],
                  ),
                ),
              ],
            ),
          ),//Contents
        ],
      ),
    );
  }
}
