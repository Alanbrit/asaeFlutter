import 'package:asae/src/pages/user/create/user_create_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:io';

class UserCreatePage extends StatelessWidget {
  UserCreateController con = Get.put(UserCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          _backgroundCover(context),
          _boxForm(context),
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
      height: MediaQuery.of(context).size.height * 0.60,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.20, left: 30, right: 30),
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
            GetBuilder<UserCreateController>(
                builder: (value) => _cardImage(context, con.imageFile, 1)
            ),
            GetBuilder<UserCreateController>(
                builder: (value) => _cardImage(context, con.imageFile2, 2)
            ),
            GetBuilder<UserCreateController>(
                builder: (value) => _cardImage(context, con.imageFile3, 3)
            ),
            _buttonEnviar(context)
          ],
        ),
      ),
    );
  }
  Widget _cardImage(BuildContext context, File? imageFile, int numberFile) {
    return GestureDetector(
      onTap: () => con.showAlertDialog(context, numberFile),
      child: Container(
        height: 110,
        width: MediaQuery.of(context).size.width * 0.2,
        child: imageFile != null
          ? Image.file(
          imageFile,
          fit: BoxFit.cover,
        )
            : Image(image: AssetImage('assets/img/image.png')),
      )
    );
  }


  Widget _buttonEnviar(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ElevatedButton(
          onPressed: () => con.createImage(context),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            'ENVIAR',
            style: TextStyle(
                color: Colors.white
            ),
          )
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
