import 'package:asae/src/pages/home/home_controller.dart';
import 'package:asae/src/pages/user/home/user_home_page.dart';
import 'package:asae/src/pages/user/list_page.dart';
import 'package:asae/src/pages/user/update/user_update_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:asae/src/utils/custom_animated_bottom_bar.dart';

class HomePage extends StatelessWidget {

  HomeController con = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _bottonBar(),
        body: Obx(()=>IndexedStack(
          index: con.indexTab.value,
          children: [
            UserHomePage(),
            ListPage(),
            UserUpdatePage()
          ],
        ))
    );
  }

  Widget _bottonBar(){
    return Obx (()=>CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Color.fromRGBO(118,164,215,1.000),
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      selectedIndex: con.indexTab.value,
      onItemSelected: (index) => con.changeTab(index),
      items: [
        BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Inicio'),
            activeColor: Colors.white,
            inactiveColor: Colors.black
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.list),
            title: Text('Mis archivos'),
            activeColor: Colors.white,
            inactiveColor: Colors.black
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text('Perfil'),
            activeColor: Colors.white,
            inactiveColor: Colors.black
        ),
      ],
    ));
  }
}
