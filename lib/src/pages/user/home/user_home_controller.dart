import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:asae/src/models/user.dart';
class UserHomeController extends GetxController {
  User user = User.fromJson(GetStorage().read('user'));
}