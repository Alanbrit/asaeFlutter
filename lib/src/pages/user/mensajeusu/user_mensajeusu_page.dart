import 'package:asae/src/pages/user/mensajeusu/user_mensajeusu_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

import '../../../models/user.dart';

class UserMensajeListPage extends StatelessWidget {
  UserMensajeListController con = Get.put(UserMensajeListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Lista de usuarios',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.lightBlue[900],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: con.getUsers(),
          builder: (context, AsyncSnapshot<List<User>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data?.isNotEmpty == true) {
                return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (_, index) {
                      return cardUser(snapshot.data![index]);
                    }
                );
              }
              else {
                return Container();
              }
            }
            else {
              return Container();
            }
          }
    ),
      ),
    );
  }


  Widget cardUser(User user) {
    return ListTile(
      onTap: () => con.goToChat(user),
      title: Text('${user.nombre ?? ''} ${user.apellidos ?? ''}'),
      subtitle: Text(user.correo ?? ''),
      leading: AspectRatio(
        aspectRatio: 1,
        child: ClipOval(
          child: FadeInImage.assetNetwork(
              fit: BoxFit.cover,
              placeholder: 'assets/img/user_profile_2.png',
              image: user.foto ?? 'https://bysperfeccionoral.com/wp-content/uploads/2020/01/136-1366211_group-of-10-guys-login-user-icon-png.jpg'
          ),
        ),
      ),
    );
  }

}