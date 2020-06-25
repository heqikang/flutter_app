import 'package:flutter/material.dart';
import 'package:flutterappzeze/pages/class_room/white_board.dart';

import 'package:flutterappzeze/root_page/app_config.dart';



class ClassRoom extends StatefulWidget {
  @override
  _ClassRoomState createState() => _ClassRoomState();
}

class _ClassRoomState extends State<ClassRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        width: ScreenWidth(context),
        height: ScreenHeight(context),
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              height: 50,
              child: Container(
                color: Colors.blue,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Text('返回',style: TextStyle(color:Colors.white),),
                      ),
                    )
                  ],
                ),
                ),
              ),
            Positioned(
              top: 70,
              left: 0,
              right: 0,
              height: ScreenHeight(context) - 70,
              child: Container(
                color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.blueGrey,
                      width: ScreenWidth(context)-230,
                      height: ScreenHeight(context) - 70,
                      child: Column(
                        children: [
                          Container(
                            width:ScreenWidth(context)-230,
                            height: ScreenHeight(context) - 70 - 120,
                            color: Colors.white,
                            child: Center(
                              child: ZZWhiteBoard()
                            ),
                          ),
                          Container(
                            width:ScreenWidth(context)-230,
                            height: 120,
                            color: Colors.brown,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    color: Colors.red,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.brown,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.yellow,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            )
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 230,
                      height: ScreenHeight(context) - 70,
                      margin: EdgeInsets.only(right:0),
                      color: Colors.yellow,
                      alignment: Alignment(0.0, 0.0),
                      child: Container(
                        child: Text('videos'),
                      ),
                    ),
                  ],
                )
              ),
            ),
            Positioned(
              right: 0,
              top: 70,
              height: 170,
              width: 230,
              child: Container(
                color: Colors.black,
              ),
            ),
            Positioned(
              right: 0,
              top: 245,
              height: 170,
              width: 230,
              child: Container(
                color: Colors.black,
              ),
            )
          ],
        )
      ),
    );
  }
}


/*
* Positioned(
              top: 20,
              left: 0,
              right: 0,
              height: 50,
              child: Container(
                color: Colors.blue,
              ),
            ),
            Positioned(
              top: 70,
              left: 0,
              right: 0,
              height: ScreenHeight(context) - 70,
              child: Container(
                color: Colors.red,
              ),
            ),
* */
/*
* Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: ScreenWidth(context),
                  height: 60,
                  color: Colors.blue,
                  child: Container(
                    child: Text('header'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: ScreenWidth(context),
                  height: ScreenHeight(context) - 20 - 60 - 10 - 10,
                  color: Colors.red,
                )
              ],
            ),
* */
