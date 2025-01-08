import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:igemtflite/myhomepage.dart';
class MySplashPage extends StatefulWidget {
  const MySplashPage({super.key});

  @override
  State<MySplashPage> createState() => _MySplashPageState();
}

class _MySplashPageState extends State<MySplashPage> {

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
          backgroundColor: Colors.white,
          onInit: () {
            debugPrint("On Init");
          },
          onEnd: () {
            debugPrint("On End");
          },
          childWidget: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/George_Floyd.png"),
                )
            )
          ),
          animationDuration: Duration(seconds: 10),
          duration: Duration(seconds: 2),
          onAnimationEnd: () => debugPrint("On Fade In End"),
          nextScreen: MyHomePage(),
        );
  }
}