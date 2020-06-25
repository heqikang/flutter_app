import 'dart:math';
import 'package:flutter/material.dart';

class ZZWhiteBoard extends StatefulWidget {
  @override
  _ZZWhiteBoardState createState() => _ZZWhiteBoardState();
}

class _ZZWhiteBoardState extends State<ZZWhiteBoard> {

  List<Path> linePathArray = List<Path>();
  Path _currentPath = Path();
  Offset _startPoint;
  int _drawType = 0;

  List<Widget> _getButtons() {
    List btnTitles = ['线','矩形','闭合曲线','圆','撤销','清空'];
    List<Widget> btns = [];
    for(int i = 0;i < btnTitles.length; i++){
      btns.add(Expanded(
        child: GestureDetector(
          onTap: (){
            print('onTap$i');
            _drawTypeChanged(i);
          },
          child: Container(
            alignment: Alignment.center,
            height: 30,
            margin: EdgeInsets.only(left: 5,right: 5),
            color: _drawType == i ? Colors.blue : Colors.green,
            child: Text(btnTitles[i],style: TextStyle(color: _drawType == i ? Colors.white : Colors.black),),
          ),
        )
      ));
    }
    return btns;
  }

  _drawTypeChanged(int type){
    _drawType = type;
    if(type == 4){//撤销
      if(linePathArray.length>0){
        setState(() {
          linePathArray = List.from(linePathArray)..removeLast();
        });
      }
    }else if(type == 5){//清空
      if(linePathArray.length>0) {
        setState(() {
          linePathArray = List.from(linePathArray)
            ..clear();
        });
      }
    }
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onPanDown: (DragDownDetails details) {
            _currentPath = Path();
            if(_drawType == 0){//一般曲线
              _currentPath = Path.from(_currentPath)
                ..moveTo(details.localPosition.dx, details.localPosition.dy);
            }else if(_drawType == 1){//矩形
              _currentPath = Path.from(_currentPath)..addRect(Rect.fromPoints(details.localPosition, details.localPosition));
            }else if(_drawType == 2){//内切圆
              _currentPath = Path.from(_currentPath)..addOval(Rect.fromPoints(details.localPosition, details.localPosition));
            }else if(_drawType == 3){//正圆
              _currentPath = Path.from(_currentPath)..addArc(Rect.fromCircle(center: details.localPosition,radius: 0.0), 0, 2.0 * pi);
            }
            _startPoint = details.localPosition;
            setState(() {});
          },
          onPanUpdate: (DragUpdateDetails details) {
            if(_drawType == 0){//一般曲线
              _currentPath = Path.from(_currentPath)
                ..lineTo(details.localPosition.dx, details.localPosition.dy);
            }else if(_drawType == 1){//矩形
              _currentPath.reset();
              _currentPath = Path.from(_currentPath)..addRect(Rect.fromPoints(_startPoint, details.localPosition));
            }else if(_drawType == 2){//内切圆
              _currentPath.reset();
              _currentPath = Path.from(_currentPath)..addOval(Rect.fromPoints(_startPoint, details.localPosition));
            }else if(_drawType == 3){//正圆
              _currentPath.reset();
              Rect frame =  Rect.fromPoints(_startPoint, details.localPosition);
              double radius = sqrt(pow(frame.width,2) * pow(frame.height,2));
              print('radius:$radius');
              _currentPath = Path.from(_currentPath)..addArc(Rect.fromCircle(center: _startPoint,radius: radius*0.5), 0, 2.0 * pi);
            }
            setState(() {});
          },
          onPanEnd: (DragEndDetails details) {
              print('onPanEnd');
              linePathArray = List.from(linePathArray)..add(_currentPath);
              setState(() {});
              _currentPath = null;
          },
          child: ClipRect(
            child: Container(
              child: CustomPaint(
                painter: _BackDrawPainter(linePathArray,drawType: _drawType),
                foregroundPainter: _RealDrawPainter(_currentPath,realDrawType: _drawType),
                isComplex: true,
                willChange: true,
                child: Container(),
              ),
            ),
          )
        ),
        Positioned(
          width: 700,
          height: 40,
          bottom: 0,
          child: Container(
//            color: Colors.red,
            child: Row(
              children: _getButtons(),
            ),
          )
        )
      ],
    );
  }
}

class _RealDrawPainter extends CustomPainter {

  Path realPath;
  int realDrawType;

  _RealDrawPainter(this.realPath, {this.realDrawType});

  @override
  void paint(Canvas canvas, Size size) {
//    print('_RealDrawPainter draw...... $realPath');
    if (realPath != null) {
//      print('内部=>_RealDrawPainter draw...... $realPath');
      var paint = Paint()
        ..style = PaintingStyle.stroke //填充
        ..color = Colors.black
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round
//        ..blendMode = BlendMode.colorDodge
        ..isAntiAlias = true
        ..strokeWidth = 2.0;
      canvas.drawPath(realPath, paint);
    }
  }
  @override
  bool shouldRepaint(_RealDrawPainter oldDelegate) {
    return realPath != null;
  }
}

class _BackDrawPainter extends CustomPainter {
  List<Path> linePaths;
  int drawType;

  _BackDrawPainter(this.linePaths, {this.drawType});

  int linesCount;

  @override
  void paint(Canvas canvas, Size size) {
//    print('_BackDrawPainter draw......');
    var custompPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..isAntiAlias = true
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;
    for (int i = 0; i < linePaths.length; i++) {
      Path path = linePaths[i];
      canvas.drawPath(path, custompPaint);
    }
  }

  @override
  bool shouldRepaint(_BackDrawPainter oldDelegate) {
    return oldDelegate.linePaths.length != this.linePaths.length;
  }
}


class ZZPath extends Path {

  bool isEraser;
  set pEraser(bool b){
    isEraser = b;
  }
  bool get pEraser {
    return isEraser;
  }
}