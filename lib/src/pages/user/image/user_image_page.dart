import 'package:asae/src/pages/user/image/user_image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/image.dart';

class UserImagePage extends StatelessWidget {

  UserImageController con = Get.put(UserImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backgroundCover(context),
          _listImage(context)
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

  

  Widget _listImage(BuildContext context) {
    return FutureBuilder(
        future: con.getMenus(),
        builder: (context, AsyncSnapshot<List<Archivo>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (_, index) {
                    return _cardMenu(snapshot.data![index], context);
                  }
              );
            }
            else {
              return _boxForm(context);
            }
          }
          else {
            return _boxForm(context);
          }
        }
    );
  }


  Widget _cardMenu(Archivo archivo, BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15, left: 30, right: 30),
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
              Container(
              margin: EdgeInsets.only(top: 5, bottom: 20),
              child: Text(
                  'IMAGENES SUBIDAS',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            Container(
                height: 115,
                width: MediaQuery.of(context).size.width * 0.2,
                child: Image(
                  image: archivo.imagen1 != null
                      ? NetworkImage(archivo.imagen1!)
                      : AssetImage('assets/img/user.png') as ImageProvider,)
            ),
            Container(
                height: 150,
                width: MediaQuery.of(context).size.width * 0.2,
                child: Image(
                  image: archivo.imagen1 != null
                      ? NetworkImage(archivo.imagen1!)
                      : AssetImage('assets/img/user.png') as ImageProvider,)
            ),
            Container(
                height: 150,
                width: MediaQuery.of(context).size.width * 0.2,
                child: Image(
                  image: archivo.imagen1 != null
                      ? NetworkImage(archivo.imagen1!)
                      : AssetImage('assets/img/user.png') as ImageProvider,)
            ),
            _buttonUpdate(context)
          ],
        ),
      ),
    );
  }



  Widget _buttonUpdate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: ElevatedButton(
          onPressed: () {},
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
  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.30, left: 30, right: 30),
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
            _buttonCreate(context)
          ],
        ),
      ),
    );
  }
  Widget _buttonCreate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ElevatedButton(
          onPressed: () => con.goToCreate(),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            'SUBIR FOTOS',
            style: TextStyle(
                color: Colors.white
            ),
          )
      ),
    );
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
  

  // Widget _cardImage(BuildContext context, File imageFile, int numberFile) {
  //   return GestureDetector(
  //     onTap: () {},
  //     child: Card(
  //       elevation: 3,
  //       child: Container(
  //         height: 100,
  //         width: MediaQuery.of(context).size.width * 0.2,
  //         child: Image(
  //           image: AssetImage('assets/img/asae.png'),
  //         ),
  //       ),
  //     ),
  //   );
  // }




}
