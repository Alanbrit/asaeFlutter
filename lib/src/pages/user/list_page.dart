import 'package:asae/src/pages/user/list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ListPage extends StatelessWidget {
  ListController con = Get.put(ListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          _buttonUpdate(context)
        ],
      ),
    );
  }

  Widget _buttonUpdate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ElevatedButton(
          onPressed: () => con.signOut(),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            'ACTUALIZAR DATOS',
            style: TextStyle(
                color: Colors.white
            ),
          )
      ),
    );
  }
}
