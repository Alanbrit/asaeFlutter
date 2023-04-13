import 'package:asae/src/providers/image_provider.dart';
import 'package:get/get.dart';
import 'package:asae/src/models/image.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class UserImageController extends GetxController{

  ArchivoProvider imageProvider = ArchivoProvider();
  List<Archivo> image = [];

  Future<List<Archivo>> getMenus() async {
    return await imageProvider.findById();
  }

  void goToImage() {
    Get.toNamed('/user/image');
  }
  void goToCreate() {
    Get.toNamed('/image/create');
  }
  void delete(BuildContext context, String id){
      Widget aceptar = ElevatedButton(
          onPressed: () async {
            await imageProvider.deleteArchivo(id);
            Get.back();
            Get.snackbar('Accion realizada con exito', 'Tus imagenes han sido borradas');
          },
          child: Text(
            'Aceptar',
            style: TextStyle(
                color: Colors.white
            ),
          )
      );
      Widget rechazar = ElevatedButton(
          onPressed: () => Get.back(),
          child: Text(
            'Cancelar',
            style: TextStyle(
                color: Colors.white
            ),
          )
      );
      Widget alertDialog = Container(
        alignment: Alignment.center,
        child: AlertDialog(
          title: Text('¿Estas seguro de eliminar tus imagenes?'),
          actions: [
            aceptar,
            rechazar
          ],
        ),
      );
      showDialog(context: context, builder: (BuildContext context){
        return alertDialog;
      });
  }
}