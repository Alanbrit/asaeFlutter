import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:asae/src/pages/user/chat/user_chats_controller.dart';
import 'package:asae/src/models/chat.dart';
import 'package:asae/src/utils/relative_time_util.dart';

class ChatsPage extends StatelessWidget {

  ChatsController con = Get.put(ChatsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de mensajes',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(118,164,215,1.000),
      ),
      body: Obx( () =>
        SafeArea(
          child: ListView(
            children: getChats(),
          ),
        ),
      ),
    );
  }

  List<Widget> getChats() {
    return con.chats.map((chat) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: cardUser(chat),
      );
    }).toList();
  }

  Widget cardUser(Chat chat) {
    return ListTile(
      onTap: () => con.goToChat(chat),
      title: Text('${chat.idUser1 == con.myUser.id ? chat.nameUser2 ?? '' : chat.nameUser1 ?? ''} ${chat.idUser1 == con.myUser.id ? chat.apellidosUser2 ?? '' : chat.apellidosUser1 ?? ''}'),
      subtitle: Text(chat.lastMessage ?? ''),
      trailing: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 7),
            child: Text(
              RelativeTimeUtil.getRelativeTime(chat.lastMessageTimestamp ?? 0),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500]
              ),
            ),
          ),
          chat.unreadMessage! > 0 ? circleMessageUnread(chat.unreadMessage ?? 0) : SizedBox(height: 0)
        ],
      ),
      leading: AspectRatio(
        aspectRatio: 1,
        child: ClipOval(
          child: FadeInImage.assetNetwork(
              fit: BoxFit.cover,
              placeholder: 'assets/img/user_profile_2.png',
              image: chat.idUser1 == con.myUser.id
                  ? chat.fotoUser2 ?? 'https://bysperfeccionoral.com/wp-content/uploads/2020/01/136-1366211_group-of-10-guys-login-user-icon-png.jpg'
                  : chat.fotoUser1 ?? 'https://bysperfeccionoral.com/wp-content/uploads/2020/01/136-1366211_group-of-10-guys-login-user-icon-png.jpg'
          ),
        ),
      ),
    );
  }

  Widget circleMessageUnread(int number){
    return Container(
      margin: EdgeInsets.only(top: 5, left: 10, right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Container(
          height: 25,
          width: 25,
          color: Colors.lightBlue[900],
          alignment: Alignment.center,
          child: Text(
            number.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 10
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

}
