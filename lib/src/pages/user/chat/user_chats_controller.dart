import 'package:asae/src/providers/chat_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:asae/src/models/chat.dart';
import 'package:asae/src/models/user.dart';
import 'package:flutter/material.dart';
import '../../home/home_controller.dart';

class ChatsController extends GetxController{
  List<Chat> chats = <Chat>[].obs;
  ChatProvider chatProvider = ChatProvider();
  User myUser = User.fromJson(GetStorage().read('user') ?? {});
  HomeController homeController = Get.find();


  ChatsController(){
    getChats();
    listenMensaje();
  }

  void getChats() async {
    var result = await chatProvider.findByIdUser(myUser.id ?? '', myUser.id ?? '', myUser.id ?? '');
    chats.clear();
    chats.addAll(result);
    if(chats?.isNotEmpty == true){
      _textYourInfo();
    }
  }

  Widget _textYourInfo(){
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 20),
      child: Text(
        'NO HAS SUBIDO FOTOS AUN',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  void listenMensaje(){
    homeController.socket.on('message/${myUser.id}', (data) {
      print('DATA EMITIDA1 $data');
      getChats();
    });
  }


  void goToChat(Chat chat){
    User user = User();
    if(chat.idUser1 == myUser.id) {
      user.id = chat.idUser2;
      user.nombre = chat.nameUser2;
      user.apellidos = chat.apellidosUser2;
      user.correo = chat.emailUser2;
      user.telefono = chat.numeroUser2;
      user.foto = chat.fotoUser2;
    }
    else {
      user.id = chat.idUser1;
      user.nombre = chat.nameUser1;
      user.apellidos = chat.apellidosUser1;
      user.correo = chat.emailUser1;
      user.telefono = chat.numeroUser1;
      user.foto = chat.fotoUser1;
    }
    Get.toNamed('/messages', arguments: {
      'user': user.toJson()
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    homeController.socket.off('message/${myUser.id}');
  }
}