import 'package:asae/src/pages/user/home/user_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class UserHomePage extends StatelessWidget {

  UserHomeController con = Get.put(UserHomeController());

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
          children: [
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(image: new AssetImage("assets/img/fondo2.png"), fit: BoxFit.cover,),
              ),
            ),
              SizedBox(
              width: 250.0,
              child: DefaultTextStyle(
              style: const TextStyle(
              fontSize: 35,
              color: Colors.white,
              shadows: [
              Shadow(
              blurRadius: 7.0,
              color: Colors.white,
              offset: Offset(0, 0),
              ),
              ],
              ),
              child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
              FlickerAnimatedText('Flicker Frenzy'),
              FlickerAnimatedText('Night Vibes On'),
              FlickerAnimatedText("C'est La Vie !"),
              ],
              onTap: () {
              print("Tap Event");
              },
              ),
              ),
              )
          ],
        )
    );
  }
}
