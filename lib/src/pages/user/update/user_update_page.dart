import 'package:asae/src/pages/user/update/user_update_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserUpdatePage extends StatelessWidget {

  UserUpdateController con = Get.put(UserUpdateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>Stack(
        children: [
          _backgroundCover(context),
          _boxForm(context),
          _imageUser(context),
          _signOut()
        ],
      )),
    );
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.35,
        color: Color.fromRGBO(118,164,215,1.000)
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.50,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.27, left: 30, right: 30),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 15,
                offset: Offset(0, 0.75)
            )
          ]
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textName(),
            _textEmail(),
            _textPhone(),
            _textFecha(),
          _buttonUpdate(context)
          ],
        ),
      ),
    );
  }


  Widget _textName(){
    return ListTile(
      leading: Icon(Icons.person),
      title: Text('${con.user.value.nombre ?? ''} ${con.user.value.apellidos ?? ''}'),
      subtitle: Text('Nombre del usuario'),
    );
  }

  Widget _textEmail(){
    return ListTile(
      leading: Icon(Icons.email),
      title: Text(con.user.value.correo ?? ''),
      subtitle: Text('Correo electronico'),
    );
  }
  Widget _textPhone(){
    return ListTile(
      leading: Icon(Icons.phone),
      title: Text(con.user.value.telefono ?? ''),
      subtitle: Text('Telefono'),
    );
  }
  Widget _textFecha(){
    return ListTile(
      leading: Icon(Icons.date_range),
      title: Text(con.user.value.fechaNacimiento ?? ''),
      subtitle: Text('Fecha de nacimiento'),
    );
  }

  Widget _buttonUpdate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: ElevatedButton(
          onPressed: () => con.goToUpdate(),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            'ACTUALIZAR DATOS',
            style: TextStyle(
                color: Colors.white
            ),
          )
      ),
    );
  }

  Widget _imageUser(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 35),
        alignment: Alignment.topCenter,
        child: CircleAvatar(
                backgroundImage: con.user.value.foto != null
                    ? NetworkImage(con.user.value.foto!)
                    : AssetImage('assets/img/user.png') as ImageProvider,
                radius: 60,
                backgroundColor: Colors.white,
              ),
      ),
    );
  }

  Widget _signOut(){
    return SafeArea(
        child: Container(
          margin: EdgeInsets.only(right: 20),
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () => con.signOut(),
            icon: Icon(
              Icons.power_settings_new,
              color: Colors.white,
              size: 30,
            ),
          ),
        )
    );
  }

}
