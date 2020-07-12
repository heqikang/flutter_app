
//import 'dart:ffi';
import 'dart:convert';
import 'dart:io';

import 'dart:typed_data';

//import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:flutter_socket_plugin/flutter_socket_plugin.dart';
import 'package:flutterappzeze/pages/models/jxh_message_model.dart';


class JXHMessageServer {

  
  static Socket _socket;

  static FlutterSocket flutterSocket;

  static void connectNettyServer(String host,int port) async{

//    _socket = await Socket.connect(host, port);
//    _socket.listen((Uint8List data) {
//      print('connectNettyServer:$data');
//    },onError: (error){
//      print('onError:$error');
//    },onDone: (){
//      print('onDone');
//    },cancelOnError: true);

    print('=======connectNettyServer');

    /// init socket
    flutterSocket = FlutterSocket();

    flutterSocket.connectListener((data){
      print("connect listener data:$data");
      sendData();
    });

    flutterSocket.errorListener((data){
      print("error listener data:$data");
    });

    flutterSocket.receiveListener((data){
      print("receive listener data:$data");
    });

    flutterSocket.disconnectListener((data){
      print("disconnect listener data:$data");
    });

    flutterSocket.createSocket(host, port).then((value) {
      print('createSocket:$value');
    }).catchError((error){
      print('error ==== $error');
    });
    flutterSocket.tryConnect().catchError((error){
      print('error ==== $error');
    });
//
//
//    _socket.flush().then((value) => {
//      print('flush=>$value')
//    },onError: (error){
//      print('flush_error=>$error');
//    });
//    _socket.write(obj)

//    _socket = IO.io('http://$host:$port',<String,dynamic> {
//      'transports': ['websocket'],
//    });
//
//    //添加回调监听
//    _socket.on("connect", (data) {
//      print('connect:$data');
//    });
//    _socket.on("connect_error", (data) {
//      print('connect_error:$data');
//    });
//    _socket.on("connect_timeout", (data) {
//      print('connect_timeout:$data');
//    });
//    _socket.on("connecting", (data) {
//      print('connecting:$data');
//    });
//    _socket.on("error", (data) {
//      print('error:$data');
//    });
//    _socket.on('disconnect', (data) {
//      print('disconnect');
//    });
//    //连接socket
//    _socket.connect();
//
//    _socket.on('message', (data) {
//      print('message:$data');
//      final dataList = data as List;
//      final ack = dataList.last as Function;
//      ack(null);
//    });

  }

  static void disConnect() async{
    print('disConnect');
    flutterSocket.tryDisconnect();
//    _socket.disconnect();
//    await _socket.close();
  }

  static void sendMessage(Uint8List bytes) async{

    flutterSocket.send(bytes.toString());
//    _socket.add(bytes);
//    await _socket.flush().then((value) => {
//      print('flush=>$value')
//    },onError: (error){
//      print('flush_error=>$error');
//    });
  }

  static void sendData(){
    Uint8List data = JXHSocketPackageHnadler.writeDataWithModel(getModel());
    sendMessage(data);
  }

  static JXHMessageModel getModel(){
    return JXHMessageModel(
        messageType: 101,
        eventId: 3349,
        roomId: '495152',
        fromUser: '7596',
        toUser: '',
        identifier: 0,
        keyValueCount: 6,
        body: {1:'7596',2:'3',3:'zeze',4:'path',5:'207596',6:'YPvL3JGphR8+5/B4CNzpWLdL73Y5qTNhxVeIp5qgPjs='}
    );
  }


}
/*
* "room_channel" : "495152",
    "agora_token" : "0069264ac8ee2bd4faf927a015774734c19IACRtcsCR1FwhM45Rx/IIJCwzD5HIUJQdRU50anZUrB5Q+0qogrDQDPXIgALaOldomMMXwQAAQAAAAAAAgAAAAAAAwAAAAAABAAAAAAA",
    "channel" : "495152",
    "users" : [ {
      "user_id" : 7596,
      "user_name" : "学员1",
      "id" : 207596,
      "type" : 1
    }
* */

