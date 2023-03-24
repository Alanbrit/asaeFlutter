import 'dart:io';
import 'package:asae/src/environment/environmet.dart';
import 'package:asae/src/models/image.dart';
import 'package:asae/src/models/user.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:convert';
class ArchivoProvider extends GetConnect {
  String url = Environmet.API_URL + 'api/image';

  Future<Stream> create(Archivo archivo, List<File> images) async {
    Uri uri = Uri.http(Environmet.API_URL_OLD, '/api/image/create');
    final request = http.MultipartRequest('POST', uri);
    for (int i = 0; i < images.length; i++){
      request.files.add(http.MultipartFile(
          'image',
          http.ByteStream(images[i].openRead().cast()),
          await images[i].length(),
          filename: basename(images[i].path)
      ));
    }

    request.fields['archivo'] = json.encode(archivo);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }
  User userSession = User.fromJson(GetStorage().read('user') ?? {});


  Future<List<Archivo>> findById() async {
    Response response = await get(
        '$url/findById/${userSession.id}',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': userSession.sessionToken ?? ''
        }
    );
    if (response.statusCode == 401) {
      Get.snackbar('Peticion denegada', 'Tu usuario no tiene los permisos requeridos');
      return [];
    }

    List<Archivo> image = Archivo.fromJsonList(response.body);
    return image;
  }
}