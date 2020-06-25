import 'package:flutter/material.dart';
import 'package:flutterappzeze/pages/cells/exam_cell.dart';

class ExamPage extends StatefulWidget {
  @override
  _ExamPageState createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> with AutomaticKeepAliveClientMixin<ExamPage>{


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('水平测试'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[  // Cells 因为现在是学习UI 我们就直接Cell往里生怼
            ExamCell(       // 这里就是我们自定义的cell 构造方法接受4个参数
              imgName: 'images/pyq.png',
              subImgName: '',
              title: '泽泽圈',
              subTitle: '',
            ),
            SizedBox(height: 10), //暂时使用SizeBox 来达到类似iOS GroupStyle的Cell分组效果
            ExamCell(       // 这里就是我们自定义的cell 构造方法接受4个参数
              imgName: 'images/pyq.png',
              subImgName: '',
              title: '泽泽的二圈',
              subTitle: '',
            ),
            SizedBox(height: 10),
            ExamCell(       // 这里就是我们自定义的cell 构造方法接受4个参数
              imgName: 'images/shop.png',
              subImgName: '',
              title: 'zeze',
              subTitle: '',
            ),
            SizedBox(height: 10),
            ExamCell(       // 这里就是我们自定义的cell 构造方法接受4个参数
              imgName: 'images/sys.png',
              subImgName: '',
              title: 'family伐木类',
              subTitle: '',
            ),
            SizedBox(height: 10),
            ExamCell(       // 这里就是我们自定义的cell 构造方法接受4个参数
              imgName: 'images/icon_game.png',
              subImgName: 'images/badge.png',
              title: '泽泽的游戏',
              subTitle: '玩游戏赢大奖',
            ),
          ],
        ),
      )
    );
  }
}
