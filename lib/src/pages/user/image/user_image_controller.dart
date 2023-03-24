import 'package:asae/src/providers/image_provider.dart';
import 'package:get/get.dart';
import 'package:asae/src/models/image.dart';


class UserImageController extends GetxController{

  ArchivoProvider imageProvider = ArchivoProvider();
  List<Archivo> image = [];

  Future<List<Archivo>> getMenus() async {
    return await imageProvider.findById();
  }

  void goToUpdate() {
    Get.toNamed('/user/update');
  }
  void goToCreate() {
    Get.toNamed('/image/create');
  }
}