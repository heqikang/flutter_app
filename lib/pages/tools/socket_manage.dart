
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';


/** 消息长度用2个字节描述 */
const int msgByteLen = 2;

/** 消息号用2个字节描述 */
const int msgCodeByteLen = 2;

/** 最小的消息长度为4个字节（即消息长度+消息号） */
const int minMsgByteLen = msgByteLen + msgCodeByteLen;


/**
 * 网络管理器类
 */
class NetworkManager{

  /** 服务器ip */
  final String host;

  /** 服务器端口 */
  final int port;

  Socket socket;

  /** 缓存的网络数据，暂未处理（一般这里有数据，说明当前接收的数据不是一个完整的消息，需要等待其它数据的到来拼凑成一个完整的消息） */
  Int8List cacheData = Int8List(0);

  NetworkManager(this.host, this.port);

  /**
   * 初始化连接服务器
   */
  void init() async{
    try {
     await Socket.connect(host, port, timeout: Duration(seconds: 2)).then((socket){
        // ignore: missing_return
        print('---------连接成功------------');

        socket.listen(decodeHandle,
            onError: errorHandler,
            onDone: doneHandler,
            cancelOnError: false);
      });
    } catch (e) {
      print("连接socket出现异常，e=${e.toString()}");
    }

  }

  /**
   * 解码处理方法
   * 处理服务器发过来的数据，注意，这里要处理粘包，这个data参数不一定是一个完整的包
   */
  void decodeHandle(newData){
    //拼凑当前最新未处理的网络数据
    print("获取到的数据newData $newData");
    cacheData = Int8List.fromList(cacheData + newData);

    //缓存数据长度符合最小包长度才尝试解码
    while(cacheData.length >= minMsgByteLen){
      //读取消息长度
      var byteData = cacheData.buffer.asByteData();
      var msgLen = byteData.getInt16(0);

      //数据长度小于消息长度，说明不是完整的数据，暂不处理
      if(cacheData.length < msgLen + msgByteLen){
        return;
      }
      //读取消息号
      int msgCode = byteData.getInt16(msgCodeByteLen);
      //读取pb数据
      int pbLen = msgLen - msgCodeByteLen;
      Int8List pbBody;
      if(pbLen > 0){
        pbBody = cacheData.sublist(minMsgByteLen, msgLen + msgByteLen);
      }

      //整理缓存数据
      int totalLen = msgByteLen + msgLen;
      cacheData = cacheData.sublist(totalLen, cacheData.length);

//      Function handler = msgHandlerPool[msgCode];
//      if(handler == null){
//        print("没有找到消息号$msgCode的处理器");
//        return;
//      }

      //处理消息
    //  handler(pbBody);
    }
  }

  void sendMsg(SocketSesson sesson){

    Map map={1:184492,2:3, 3:'大班1', 4:'path', 5:20184492, 6:'SLJGdMyAgBkiX6MxVjAFhJUICfFj4hFIiK7SH/n49kw='};
    SocketSesson testsesson=new SocketSesson(
        0,
        101,
        15471,
        '458182',
        '184492',
        '',
        0,
        6,
     map);
  //  Uint8List b=encode(testsesson.fromUser);
    //序列化pb对象
    //给服务器发消息
    try {

//      Uint8List l=new Uint8List(12+4+encodedLength);
//

     // print("给服务端发送消息，消息号=$msgCode");
    } catch (e) {
      print("send捕获异常：，e=${e.toString()}");
    }
  }

  void errorHandler(error, StackTrace trace){
    print("捕获socket异常信息：error=$error，trace=${trace.toString()}");
    socket.close();
  }

  void doneHandler(){
    socket.destroy();
    print("socket关闭处理");
  }

}


class SocketSesson{
  int messageLength;
  double messageType;
  int eventId;
  String roomId;
  String fromUser;
  String toUser;
  int identifier;
  int keyValueCount;
  Map bodyContent;

  SocketSesson(this.messageLength, this.messageType, this.eventId, this.roomId,
      this.fromUser, this.toUser, this.identifier, this.keyValueCount,
      this.bodyContent);
}

