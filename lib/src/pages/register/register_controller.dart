import 'dart:io';
import 'dart:convert';
import 'package:asae/src/models/response_api.dart';
import 'package:asae/src/models/user.dart';
import 'package:asae/src/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class RegisterController extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController fechaController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  ImagePicker picker = ImagePicker();
  File? imageFile;


  Future<void> register(BuildContext context) async {
    String email = emailController.text.trim();
    String nombre = nombreController.text;
    String apellido = apellidoController.text;
    String fecha = fechaController.text;
    String telefono = telefonoController.text;
    String confirmPassword = confirmPasswordController.text.trim();
    String password = passwordController.text.trim();
    if(isValidForm(email, nombre, apellido, fecha, telefono, confirmPassword, password)){
      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Registrando datos...');
      User user = User(
          correo: email,
          nombre: nombre,
          apellidos: apellido,
          fechaNacimiento: fecha,
          telefono: telefono,
          password: password,
      );

      Stream stream = await usersProvider.createWithImage(user, imageFile!);

      stream.listen((res) {
        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
        if (responseApi.success == true) {
          GetStorage().write('user', responseApi.data);
          goToHomePage();
        } else{
          Get.snackbar('Registro fallido', responseApi.message ?? '');
        }
      });
    }
  }

  void goToHomePage(){
    Get.offNamedUntil('/home', (route) => false);
  }

  bool isValidForm(String email, String nombre, String apellido, String fecha, String telefono, String password, String confirmPassword) {
    if(email.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar el email');
      return false;
    }
    if(!GetUtils.isEmail(email)){
      Get.snackbar('Formulario no valido', 'El email no es valido');
      return false;
    }
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
    if(confirmPassword.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes confirmar su contraseña');
      return false;
    }
    if(password != confirmPassword){
      Get.snackbar('Formulario no valido', 'Las contraseñas no coinciden');
      return false;
    }
    if(imageFile == null){
      Get.snackbar('Formulario no valido', 'Debes seleccionar una imagen');
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