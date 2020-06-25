import 'package:flutter/material.dart';
import 'package:flutterappzeze/pages/class_room/class_room.dart';

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
              return ClassRoom();
            }));
          },
          child: Text('进入教室'),
        ),
      ),
    );;
  }
}
