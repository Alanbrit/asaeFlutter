import 'dart:convert';
import 'dart:io';
import 'package:asae/src/models/response_api.dart';
import 'package:asae/src/pages/user/update/user_update_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:asae/src/models/user.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:asae/src/providers/user_provider.dart';

class UserInfoController extends GetxController{

  User user = User.fromJson(GetStorage().read('user'));

  UserUpdateController userUpdateController = Get.find();

  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController fechaController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();

  ImagePicker picker = ImagePicker();
  File? imageFile;

  UsersProvider usersProvider = UsersProvider();

  UserInfoController() {
    nombreController.text = user.nombre ?? '';
    apellidoController.text = user.apellidos ?? '';
    fechaController.text = user.fechaNacimiento ?? '';
    telefonoController.text = user.telefono ?? '';
  }

  Future<void> updat(BuildContext context) async {
    String nombre = nombreController.text;
    String apellido = apellidoController.text;
    String fecha = fechaController.text;
    String telefono = telefonoController.text;

    if(isValidForm(nombre, apellido, fecha, telefono)){
      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Actualizando datos...');
      User myUser = User(
        id: user.id,
        nombre: nombre,
        apellidos: apellido,
        fechaNacimiento: fecha,
        telefono: telefono,
        sessionToken: user.sessionToken
      );

      if(imageFile == null){
        ResponseApi responseApi = await usersProvider.update(myUser);
        print('Response API Update: ${responseApi.data}');
        Get.snackbar('Proceso terminado', responseApi.message ?? '');
        progressDialog.close();
        if (responseApi.success == true){
          GetStorage().write('user', responseApi.data);
          userUpdateController.user.value = User.fromJson(GetStorage().read('user') ?? {});
        }
      }
      else{
        Stream stream = await usersProvider.updateWithImage(myUser, imageFile!);
        stream.listen((res) {
          progressDialog.close();
          ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
          Get.snackbar('Proceso terminado', responseApi.message ?? '');
          print('Response API Update: ${responseApi.data}');
          if (responseApi.success == true) {
            GetStorage().write('user', responseApi.data);
            userUpdateController.user.value = User.fromJson(GetStorage().read('user') ?? {});
          } else{
            Get.snackbar('Registro fallido', responseApi.message ?? '');
          }
        });
      }
    }
  }

  bool isValidForm(String nombre, String apellido, String fecha, String telefono) {
    if(nombre.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar su nombre');
      return false;
    }
    if(apellido.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar su apellido');
      return false;
    }
    if(fecha.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar su fecha de nacimiento');
      return false;
    }
    if(telefono.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar su número telefonico');
      return false;
    }
    return true;
  }

  Future selectImage(ImageSource imageSource) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null){
      imageFile = File(image.path);
      update();
    }
  }

  void showAlertDialog(BuildContext context){
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.gallery);
        },
        child: Text(
          'GALERIA',
          style: TextStyle(
              color: Colors.black
          ),
        )
    );
    Widget camaraButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.camera);
        },
        child: Text(
          'CAMARA',
          style: TextStyle(
              color: Colors.black
          ),
        )
    );
    Widget alertDialog = AlertDialog(
      title: Text('Selecciona una opción'),
      actions: [
        galleryButton,
        camaraButton
      ],
    );
    showDialog(context: context, builder: (BuildContext context){
      return alertDialog;
    });
  }
}