import 'dart:convert';
import 'dart:typed_data';
import 'package:buffer/buffer.dart';


class JXHMessageModel {

  final int messageLength;
  final int messageType;
  final int eventId;
  final String roomId;
  final String fromUser;
  final String toUser;
  final int identifier;
  final int keyValueCount;
  final Map<int,String> body;

  JXHMessageModel({
      this.messageLength,
      this.messageType,
      this.eventId,
      this.roomId,
      this.fromUser,
      this.toUser,
      this.identifier,
      this.keyValueCount,
      this.body}
      );
  @override
  String toString() {
    // TODO: implement toString
    return '${this.messageLength}\n${this.messageType}\n${this.eventId}\n${this.roomId}\n${this.fromUser}\n${this.toUser}\n${this.identifier}\n${this.keyValueCount}\n${this.body}';
  }

}

class JXHSocketPackageHnadler {


//  BytesBuffer buffer;
//  ByteData data;
//  void test(){
//    data.set
//  }

  // 模型数据 --> 二进制数据
  static Uint8List writeDataWithModel(JXHMessageModel model){

    ByteDataWriter contentWrite = ByteDataWriter();

    contentWrite.writeInt16(model.messageType);
    contentWrite.writeInt32(model.eventId);

    contentWrite.writeInt32(model.roomId.length);
    contentWrite.write(model.roomId.toString().codeUnits);

    contentWrite.writeInt32(model.fromUser.length);
    contentWrite.write(model.fromUser.toString().codeUnits);

    contentWrite.writeInt32(model.toUser.length);
    contentWrite.write(model.toUser.toString().codeUnits);

    contentWrite.writeInt32(model.identifier);
    contentWrite.writeInt32(model.body.length);

    List<int> allKeys = model.body.keys.toList();
    for(int i = 0;i<allKeys.length;i++){
      int key = allKeys[i];
      String value = model.body[key];
      contentWrite.writeInt32(key);
      contentWrite.writeInt32(value.length);
      contentWrite.write(value.toString().codeUnits);
    }

    ByteDataWriter sumWriteData = ByteDataWriter(bufferLength: contentWrite.toBytes().length+4);
    print('lenght:${contentWrite.toBytes().length}');
    sumWriteData.writeInt32(contentWrite.toBytes().length);
    sumWriteData.write(contentWrite.toBytes());
    print('sum-lenght:${sumWriteData.bufferLength}');
    return sumWriteData.toBytes();
  }

  // 二进制数据 --> 模型数据
  static JXHMessageModel getSocketModelFromData(Uint8List bytes){

    ByteDataReader reader = ByteDataReader();
    //读入数据
    reader.add(bytes);
    //这个类好像是内部已经维护了offset,这里是自动偏移
    int messageLength = reader.readInt32();
    int messageType = reader.readInt16();
    int eventId = reader.readInt32();

    int roomIdLen = reader.readInt32();
    String roomId = String.fromCharCodes(reader.read(roomIdLen));

    int fromUserLen = reader.readInt32();
    String fromUser = String.fromCharCodes(reader.read(fromUserLen));

    int toUserLen = reader.readInt32();
    String toUser = String.fromCharCodes(reader.read(toUserLen));

    int identifier = reader.readInt32();

    int keyValueCount = reader.readInt32();
    Map<int,String> body = Map();
    for(int i = 0;i<keyValueCount;i++){
      int key = reader.readInt32();
      int valueLen = reader.readInt32();
      String value =  Utf8Decoder().convert(reader.read(valueLen));
//      String.fromCharCodes();
      body[key] = value;
    }

    return JXHMessageModel(
      messageLength: messageLength,
      messageType: messageType,
      eventId: eventId,
      roomId: roomId,
      fromUser: fromUser,
      toUser: toUser,
      identifier: identifier,
      keyValueCount: keyValueCount,
      body: body
    );
  }

  //获取包长
  static int getContentLength(Uint8List bytes) {
    ByteDataReader reader = ByteDataReader();
    reader.add(bytes);
    return reader.readInt32();
  }


}

