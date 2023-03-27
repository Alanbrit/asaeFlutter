import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:asae/src/models/user.dart';
import 'package:asae/src/providers/user_provider.dart';

class UserMensajeListController extends GetxController{
  List<User> user = [];
  UsersProvider userProvider = UsersProvider();
  User user1 = User.fromJson(GetStorage().read('user') ?? {});

  Future<List<User>> getUsers() async {
      if(user1.idRol == "1"){
        return await userProvider.findByRol("2");
      }else{
        return await userProvider.findByRol("1");
      }
  }

  void goToChat(User user){
    Get.toNamed('/messages', arguments: {
      'user': user.toJson()
    });
  }


}