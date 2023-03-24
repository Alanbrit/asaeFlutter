import 'package:asae/src/pages/user/home/user_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class UserHomePage extends StatelessWidget {

  UserHomeController con = Get.put(UserHomeController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _boxForm(context),
        ],
      ),
    );
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 1,
      decoration: const BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment(0.0, 1.0), // 10% of the width, so there are ten blinds.
          colors: const <Color>[
            Color.fromRGBO(118,164,215,1.000),
            Color.fromRGBO(255, 255, 250, 1.000)
          ], // red to yellow
          tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
      ),
    );
  }
  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.40,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.40, left: 50, right: 50),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textYourInfo(),
          ],
        ),
      ),
    );
  }

  Widget _textYourInfo(){
    return SizedBox(
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 50,
          color: Color.fromRGBO(118,164,215,1.000),
          shadows: [
            Shadow(
              blurRadius: 7.0,
              color: Color.fromRGBO(118,164,215,1.000),
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            FlickerAnimatedText('Bienvenido...'),
            FlickerAnimatedText('${con.user.nombre}'),
            FlickerAnimatedText('${con.user.apellidos}'),
          ],
          onTap: () {
            print("Tap Event");
          },
        ),
      ),
    );
  }



  // Widget _textYourInfo(){
  //   return DefaultTextStyle(
  //     style: const TextStyle(
  //       fontSize: 60.0,
  //     ),
  //     child: AnimatedTextKit(
  //       animatedTexts: [
  //         WavyAnimatedText('Bienvenido: '),
  //         WavyAnimatedText('${con.user.nombre}'),
  //         WavyAnimatedText('${con.user.apellidos}'),
  //       ],
  //       isRepeatingAnimation: true,
  //       onTap: () {
  //         print("Tap Event");
  //       },
  //     ),
  //   );
  // }

}
