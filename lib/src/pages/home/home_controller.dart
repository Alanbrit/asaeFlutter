import 'package:asae/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:asae/src/environment/environmet.dart';
import 'package:socket_io_client/socket_io_client.dart';

class HomeController extends GetxController{
  User user = User.fromJson(GetStorage().read('user') ?? {});
  HomeController(){
    print('USUARIO DE SESION: ${user.toJson()}');
    connectAndListen();
  }
  var indexTab = 0.obs;

  void changeTab(int index) {
    indexTab.value = index;
  }

  void signOut() {
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false);
  }
  Socket socket = io('${Environmet.API_URL}chat', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false
  });

  void connectAndListen(){
    if(user.id != null){
      socket.connect();
      socket.onConnect((data) {
        print('USUARIO CONECTADO A SOCKET IO');
      });
    }
  }



  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    socket.disconnect();
  }
}