import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:asae/src/environment/environmet.dart';
import 'package:asae/src/models/response_api.dart';
import 'package:asae/src/models/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class UsersProvider extends GetConnect {
  String url = Environmet.API_URL + 'api/users';
  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<Response> create(User user) async {
    Response response = await post(
        '$url/create',
        user.toJson(),
        headers: {
          'Content-Type': 'application/json'
        }
    );
    return response;
  }

  //Sin imagen
  Future<ResponseApi> update(User user) async {
    Response response = await put(
        '$url/updateWithouImage',
        user.toJson(),
        headers: {
          'Content-Type': 'application/json'
        }
    );
    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo actualizar la indormación');
      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  Future<Stream> updateWithImage(User user, File image) async {
    Uri uri = Uri.http(Environmet.API_URL_OLD, '/api/users/update');
    final request = http.MultipartRequest('PUT', uri);
    request.files.add(http.MultipartFile(
        'image',
        http.ByteStream(image.openRead().cast()),
        await image.length(),
        filename: basename(image.path)
    ));
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<Stream> createWithImage(User user, File image) async {
    Uri uri = Uri.http(Environmet.API_URL_OLD, '/api/users/createWithImage');
    final request = http.MultipartRequest('POST', uri);
    request.files.add(http.MultipartFile(
      'image',
      http.ByteStream(image.openRead().cast()),
      await image.length(),
      filename: basename(image.path)
    ));
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<ResponseApi> login(String correo, String password) async {
    Response response = await post(
        '$url/login',
        {
          'correo': correo,
          'password': password
        },
        headers: {
          'Content-Type': 'application/json'
        }
    );

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo ejecutar la peticion');
      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  Future<List<User>> findByRol(String id_rol) async {
    Response response = await get(
        '$url/findByRol/$id_rol',
        headers: {
          'Content-Type': 'application/json'
        }
    );
    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo ejecutar la peticion');
      return [];
    }

    List<User> user = User.fromJsonList(response.body);
    return user;
  }

}