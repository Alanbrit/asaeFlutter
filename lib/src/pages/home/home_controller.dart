import 'package:asae/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController{
  User user = User.fromJson(GetStorage().read('user') ?? {});
  HomeController(){
    print('USUARIO DE SESION: ${user.toJson()}');
  }
  var indexTab = 0.obs;

  void changeTab(int index) {
    indexTab.value = index;
  }

  void signOut() {
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false);
  }
}