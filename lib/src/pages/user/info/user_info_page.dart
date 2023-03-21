import 'package:asae/src/pages/user/info/user_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserInfoPage extends StatelessWidget {
  UserInfoController con = Get.put(UserInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          _backgroundCover(context),
          _boxForm(context),
          _imageUser(context),
          _buttonBack()
        ],
      ),
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
      height: MediaQuery.of(context).size.height * 0.55,
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
            _textYourInfo(),
            _textFieldName(),
            _textFieldApellidos(),
            _textFieldFecha(context),
            _textFieldTelefono(),
            _buttonUpdate(context)
          ],
        ),
      ),
    );
  }

  Widget _textFieldName(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: con.nombreController,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
            hintText: 'Nombre(s)',
            prefixIcon: Icon(Icons.account_circle)
        ),
      ),
    );
  }

  Widget _textFieldApellidos(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: con.apellidoController,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
            hintText: 'Apellidos',
            prefixIcon: Icon(Icons.account_circle_outlined)
        ),
      ),
    );
  }

  Widget _textFieldFecha(BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: con.fechaController,
        decoration: InputDecoration(
            hintText: 'Fecha (AAAA-MM-DD)',
            prefixIcon: Icon(Icons.date_range)
        ),
        readOnly: true,
        onTap: () async{
          DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100)
          );
          if (newDate!= null) {
            String formattedDate = DateFormat.yMd().format(newDate);
            con.fechaController.text=formattedDate.toString();
          }else{
            print('No selecciono');
          }
        },
      ),
    );
  }

  Widget _textFieldTelefono(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: con.telefonoController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Número telefonico',
            prefixIcon: Icon(Icons.phone)
        ),
      ),
    );
  }


  Widget _textYourInfo(){
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 30),
      child: Text(
        'INGRESA ESTA INFORMACIÓN',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buttonUpdate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ElevatedButton(
          onPressed: () => con.updat(context),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            'ACTUALIZAR',
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
        child: GestureDetector(
            onTap: () => con.showAlertDialog(context),
            child: GetBuilder<UserInfoController> (
              builder: (value) => CircleAvatar(
                backgroundImage: con.imageFile != null
                    ? FileImage(con.imageFile!)
                    : con.user.foto != null
                      ? NetworkImage(con.user.foto!)
                      : AssetImage('assets/img/user1.png') as ImageProvider,
                radius: 60,
                backgroundColor: Colors.white,
              ),
            )
        ),
      ),
    );
  }

  Widget _buttonBack(){
    return SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 20),
          alignment: Alignment.topLeft,
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 30,
            ),
          ),
        )
    );
  }
}
