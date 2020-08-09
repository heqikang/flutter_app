import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutterappzeze/pages/class_room/class_room.dart';

import 'package:buffer/buffer.dart';
import 'package:flutterappzeze/pages/models/jxh_message_model.dart';
import 'package:flutterappzeze/pages/tools/jxh_file_manager.dart';
import 'package:flutterappzeze/pages/tools/jxh_message_server.dart';

import 'package:flutter_socket_plugin/flutter_socket_plugin.dart';
import 'package:flutterappzeze/pages/views/jxh_web_view.dart';
import 'package:flutterappzeze/pages/views/my_widget.dart';
import 'package:flutterappzeze/root_page/home_page.dart';
import 'package:local_assets_server/local_assets_server.dart';
import 'package:path_provider/path_provider.dart';

class PersonalPage extends StatefulWidget {

  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {

  bool isListening = false;
  String address;
  int port;
  Uri fileURl;
  String _host = "39.97.123.117";
  int _port = 8081;
  String receiveMessage = "";
  Socket _socket;

  final GlobalKey testWidgetKey = GlobalKey();

//  void init() async{
//    try {
//      await Socket.connect('39.97.123.117', 8081, timeout: Duration(seconds: 5)).then((socket){
//        // ignore: missing_return
//        print('---------连接成功------------');
//        socket.listen(decodeHandle,
//            onError: errorHandler,
//            onDone: doneHandler,
//            cancelOnError: false);
//        _socket = socket;
//      });
//    } catch (e) {
//      print("连接socket出现异常，e=${e.toString()}");
//    }
//  }
//
//  void decodeHandle(Uint8List data){
//    print('收到消息:$data');
//    print('解析消息');
//    JXHMessageModel dataModel = JXHSocketPackageHnadler.getSocketModelFromData(data);
//    print('model == ${dataModel.messageLength}');
//    print('model == ${dataModel.messageType}');
//    print('model == ${dataModel.eventId}');
//    print('model == ${dataModel.roomId}');
//    print('model == ${dataModel.fromUser}');
//    print('model == ${dataModel.toUser}');
//    print('model == ${dataModel.identifier}');
//    print('model == ${dataModel.keyValueCount}');
//    print('model == ${dataModel.body}');
//  }
//
//  void errorHandler(error, StackTrace trace){
//    print("捕获socket异常信息：error=$error，trace=${trace.toString()}");
//  }
//
//  void doneHandler(){
//    print("socket关闭处理");
//  }
//
//  _sendMsg(){
//    Uint8List data = JXHSocketPackageHnadler.writeDataWithModel(JXHMessageServer.getModel());
//    JXHMessageModel model = JXHSocketPackageHnadler.getSocketModelFromData(data);
//    print(model.toString());
//    print('发送消息:$data');
//   _socket.add(data);
//  }
//
//  _toDoSth(){
//    JXHMessageModel model = JXHMessageModel(
//        messageType: 402,
//        eventId: 456,
//        roomId: '1234567890=qwertyuio',
//        fromUser: 'zezefamily_009999',
//        toUser: 'hello_cc_111122',
//        identifier: 12345,
//        keyValueCount: 4,
//        body: {1:'11111',2:'22222',3:'33333',4:'444444'}
//    );
//    Uint8List data = JXHSocketPackageHnadler.writeDataWithModel(model);
//    print('data == $data');
//    JXHMessageModel dataModel = JXHSocketPackageHnadler.getSocketModelFromData(data);
//    print('model == ${dataModel.messageLength}');
//    print('model == ${dataModel.messageType}');
//    print('model == ${dataModel.eventId}');
//    print('model == ${dataModel.roomId}');
//    print('model == ${dataModel.fromUser}');
//    print('model == ${dataModel.toUser}');
//    print('model == ${dataModel.identifier}');
//    print('model == ${dataModel.keyValueCount}');
//    print('model == ${dataModel.body}');
//    JXHMessageServer.sendMessage(data);
//  }
//
//  _connectNettyServer(){
//    print('连接socket');
//    init();
////    print('_connectNettyServer');
////    JXHMessageServer.connectNettyServer("39.97.123.117", 8091);
//  }
  @override
  void initState() {
    super.initState();

    var m = JXHFileManager.instance..loadAppFileDirectory();

    print('=====$m');
    _getLocalFile().then((String path){
      fileURl =  Uri.file(path);
      print('fileURl:${fileURl.toString()}');
      _testPath();
      _initServer();
    });
//    _getDocumentPath().then((value){
//      print(value);
//      Directory('$value/zeze').create();
//      File('zzz')..create();
//    });
//    _getDocumentDir().then((Directory value) {
//      print('dir:$value');
//      value.createSync();
//      value.create();
//    });

  }

  Future<String> _getDocumentPath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    return appDocPath;
  }
  Future<Directory> _getDocumentDir() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
//    String appDocPath = appDocDir.path;
    return appDocDir;
  }

  Future<String> _getLocalFile() async {
    // get the path to the document directory.
    String dir = (await getApplicationDocumentsDirectory()).path;
    return '$dir/classlist/index.html';
      //new File('$dir/classlist/index.html');
  }


  _testPath() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    print('tempPath:$tempPath\nappDocPath:$appDocPath');
  }

  _initServer() async {
    final server = new LocalAssetsServer(
      address: InternetAddress.loopbackIPv4,
      assetsBasePath: 'resource/',
    );

    final address = await server.serve();

    setState(() {
      this.address = address.address;
      port = server.boundPort;
      isListening = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我'),
      ),
      body: Container(
        key: testWidgetKey,
        child: isListening ? JXHWebView(
          loadUrl: fileURl.toString(),
          jsName: 'jxhStudent',
          onMessageReceived: (String message) {
//            print('message == $message');
            print('width:${testWidgetKey.currentContext.size.width}');
            print('height:${testWidgetKey.currentContext.size.height}');
          },
        ):Container(),
      ),
    );
  }
}

/*
*
*             GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                  return HomePage();
                }));
              },
              child: Text('进入教室'),
            ),
            GestureDetector(
              onTap: (){
                _connectNettyServer();
              },
              child: Text('socket连接'),
            ),
            GestureDetector(
              onTap: (){
                _sendMsg();

              },
              child: Text('发消息'),
            ),
            GestureDetector(
              onTap: (){
                JXHMessageServer.disConnect();
              },
              child: Text('socket断开'),
            ),
            GestureDetector(
              onTap: (){
                _toDoSth();
              },
              child: Text('二进制<=>模型 转换'),
            ),
            MyWidget(),
* */

