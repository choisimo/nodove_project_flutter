import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nodove_flutter/state/url.dart';
import 'package:socket_io_client/socket_io_client.dart' as sio;

class SocketIO{
  late sio.Socket socket;
  
  SocketIO(){
    const storage = FlutterSecureStorage();
    Future<String?> token = storage.read(key: "userToken");
    socket = sio.io(Url.chatServerSocketUrl,
      sio.OptionBuilder()
        .setQuery({"userToken" : token})
        .setTransports(['websocket'])
        .disableAutoConnect()
        .build()
    );

    socket.connect();
  }

  void loadingPrevious(String roomId,int pageSize,int pageNumber){
    final prevMsg = {
      "roomId": roomId,
      "pageSize" : pageSize,
      "pageNumber": pageNumber
    };
    print(socket.connected);
    socket.emit("loadingPreviousMessages",prevMsg);
    socket.on("previousMessages",(message){
      print(message);
    });
  }

  void sendMessage(Object msg){
    socket.emitWithAck("message" , msg ,
    ack : (message){
      print(message);
    });
  }
  void disconnectSocket(){
    socket.disconnect();
  }
}

class PreviousMessagesDto{
  String roomId;
  int pageSize;
  int pageNumber;
  PreviousMessagesDto({
    required this.roomId,
    this.pageSize = 0,
    this.pageNumber = 0
  });
}

class MessageDto{
  String sender;
  String content;
  String roomId;
  MessageDto({
    required this.sender,
    required this.content,
    required this.roomId,
  });
}