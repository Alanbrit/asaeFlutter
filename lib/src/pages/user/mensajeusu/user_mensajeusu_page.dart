import 'package:asae/src/pages/user/mensajeusu/user_mensajeusu_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:asae/src/environment/environmet.dart';
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
        backgroundColor: Color.fromRGBO(118,164,215,1.000),
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
          child: CircleAvatar(
            backgroundImage: user.foto != null
                ? NetworkImage(user.foto!)
                : AssetImage('assets/img/user.png') as ImageProvider,
            radius: 60,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }

}