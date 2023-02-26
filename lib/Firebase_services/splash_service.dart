import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_application/home_screen.dart';
import 'package:flutter_web_application/login.dart';



class SplashServices {
  void isLogin(BuildContext context) {
    //auth used for firebase authentication
    final auth = FirebaseAuth.instance;
    // user jo login ho ga
    final user = auth.currentUser;
    

    if (user != null) {
      //Timer it will take 2 sec and than move to another page
      Timer(const Duration(seconds: 2), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      });
    } 
  
    else {

         Timer(const Duration(seconds: 2), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Login()));
      });

    }
  }
}
