import 'dart:convert';
import 'package:get/get_connect.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:asae/src/environment/environmet.dart';
import 'package:asae/src/models/response_api.dart';
import 'package:asae/src/models/user.dart';

import '../models/mensaje.dart';

class MensajeProvider extends GetConnect {

  String url = Environmet.API_URL + 'api/mensajes';
  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<ResponseApi> create(Mensaje mensaje) async{
    Response response = await post(
        '$url/create',
        mensaje.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    );
    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo actualizar la información');
      return ResponseApi();
    }
    if (response.statusCode == 401) {
      Get.snackbar('Error', 'No estas autorizado para realizar esta petición');
      return ResponseApi();
    }
    ResponseApi responsiveApi = ResponseApi.fromJson(response.body);
    return responsiveApi;
  }
  Future<List<Mensaje>> findByChat(String id_chat) async {
    Response response = await get(
        '$url/findByChat/$id_chat',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    );
    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada', 'Tu usuario no tiene los permisos requeridos');
      return [];
    }

    List<Mensaje> mensaje = Mensaje.fromJsonList(response.body);
    return mensaje;
  }
  Future<ResponseApi> updateToSeen(String idMensaje) async{
    Response response = await put(
        '$url/updateToSeen',
        {
          'id': idMensaje
        },
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    );
    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo actualizar la información');
      return ResponseApi();
    }
    if (response.statusCode == 401) {
      Get.snackbar('Error', 'No estas autorizado para realizar esta petición');
      return ResponseApi();
    }
    ResponseApi responsiveApi = ResponseApi.fromJson(response.body);
    return responsiveApi;
  }
}