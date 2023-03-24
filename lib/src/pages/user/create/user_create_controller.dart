import 'dart:convert';
import 'package:asae/src/models/image.dart';
import 'package:asae/src/models/response_api.dart';
import 'package:asae/src/models/user.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:asae/src/providers/image_provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';


class UserCreateController extends GetxController{
  ArchivoProvider imageProvider = ArchivoProvider();
  ImagePicker picker = ImagePicker();
  File? imageFile;
  File? imageFile2;
  File? imageFile3;
  User userSession = User.fromJson(GetStorage().read('user') ?? {});


  void createImage(BuildContext context) async{
    ProgressDialog progressDialog = ProgressDialog(context: context);
    if (imageFile == null){
      Get.snackbar('Formulario no valido', 'Selecciona la imagen numero uno');
    }
    if (imageFile2 == null){
      Get.snackbar('Formulario no valido', 'Selecciona la imagen numero dos');
    }
    if (imageFile3 == null){
      Get.snackbar('Formulario no valido', 'Selecciona la imagen numero tres');
    }
    else
    {
      Archivo archivo = Archivo(
        idUsuario: userSession.id
      );
      progressDialog.show(max: 100, msg: 'Espere un momento..');
      List<File> images = [];
      images.add(imageFile!);
      images.add(imageFile2!);
      images.add(imageFile3!);
      Stream stream = await imageProvider.create(archivo, images);
      stream.listen((res) {
        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
        Get.snackbar('Proceso terminado', responseApi.message ?? '');
      });
    }
  }


  Future selectImage(ImageSource imageSource, int numberFile) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null){
      if (numberFile == 1){
        imageFile = File(image.path);
      }
      if (numberFile == 2){
        imageFile2 = File(image.path);
      }
      if (numberFile == 3){
        imageFile3 = File(image.path);
      }

      update();
    }
  }

  void showAlertDialog(BuildContext context, int numberFile){
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.gallery, numberFile);
        },
        child: Text(
          'GALERIA',
          style: TextStyle(
              color: Colors.white
          ),
        )
    );
    Widget camaraButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.camera, numberFile);
        },
        child: Text(
          'CAMARA',
          style: TextStyle(
              color: Colors.white
          ),
        )
    );
    Widget alertDialog = Container(
      alignment: Alignment.center,
      child: AlertDialog(
        title: Text('Selecciona una opción'),
        actions: [
          galleryButton,
          camaraButton
        ],
      ),
    );
    showDialog(context: context, builder: (BuildContext context){
      return alertDialog;
    });
  }
}