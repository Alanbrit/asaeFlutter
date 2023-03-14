import 'package:asae/src/models/response_api.dart';
import 'package:asae/src/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  void goToRegister() {
    Get.toNamed('/register');
  }

  void login() async {
    String correo = emailController.text.trim();
    String password = passwordController.text.trim();
    if(isValidForm(correo, password)){

      ResponseApi responseApi = await usersProvider.login(correo, password);
      print('Responsive Api: ${responseApi.toJson()}');
      if (responseApi.success == true) {
        GetStorage().write('user', responseApi.data);
        goToHomePage();
      }else {
        Get.snackbar('Login fallido', responseApi.message ?? '');
      }
    }
  }

  void goToHomePage(){
    Get.offNamedUntil('/home', (route) => false);
  }

  bool isValidForm(String correo, String password) {
    if(correo.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar el email');
      return false;
    }
    if(!GetUtils.isEmail(correo)){
      Get.snackbar('Formulario no valido', 'El email no es valido');
      return false;
    }
    if(password.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar el password');
      return false;
    }
    return true;
  }
}