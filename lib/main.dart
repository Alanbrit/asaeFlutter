import 'package:asae/src/pages/register/resgister_page.dart';
import 'package:asae/src/pages/user/create/user_create_page.dart';
import 'package:asae/src/pages/user/home/user_home_page.dart';
import 'package:asae/src/pages/user/image/user_image_page.dart';
import 'package:asae/src/pages/user/info/user_info_page.dart';
import 'package:asae/src/pages/user/mensajeusu/user_mensajeusu_page.dart';
import 'package:asae/src/pages/user/messages/user_messages_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:asae/src/pages/login/login_page.dart';
import 'package:get_storage/get_storage.dart';
import 'package:asae/src/pages/home/home_page.dart';
import 'package:asae/src/pages/user/update/user_update_page.dart';


void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Asae',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/user/update/update', page: () => UserUpdatePage()),
        GetPage(name: '/user/info/info', page: () => UserInfoPage()),
        GetPage(name: '/user/home', page: () => UserHomePage()),
        GetPage(name: '/user/image', page: () => UserImagePage()),
        GetPage(name: '/image/create', page: () => UserCreatePage()),
        GetPage(name: '/messages', page: () => MessagesPage()),
        GetPage(name: '/chats/users', page: () => UserMensajeListPage())
      ],
      theme: ThemeData(
        primaryColor: Color.fromRGBO(118,164,215,1.000),
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: Color.fromRGBO(118,164,215,1.000),
            onPrimary: Colors.black,
            secondary: Color.fromRGBO(118,164,212,1.000),
            onSecondary: Colors.grey,
            error: Colors.grey,
            onError: Colors.grey,
            background: Colors.grey,
            onBackground: Colors.grey,
            surface: Colors.grey,
            onSurface: Colors.grey,
        )
      ),
      navigatorKey: Get.key,
    );
  }
}
