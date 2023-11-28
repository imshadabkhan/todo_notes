import 'dart:async';


import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_notes/view/home_view/home.dart';
class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}



class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 4), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home_View()),),);
  }

  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:Color(0xffFFDD43),
      body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
          width: 250.0,
          child: DefaultTextStyle(
            style:  TextStyle(
              fontSize: 35,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 7.0,
                  color: Colors.white,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Center(
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  FlickerAnimatedText('Todo '),
                  FlickerAnimatedText(' Notes_ App'),
                ],

              ),
            ),
          ),
    ),
        ],
      ),
      
    ],),);
  }
}
