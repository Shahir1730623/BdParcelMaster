import 'dart:async';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import '../assistants/assistant_methods.dart';
import '../authentication/background.dart';
import '../authentication/login_screen.dart';
import '../global/global.dart';
import '../mainScreens/main_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

  startTimer()
  {
    fAuth.currentUser != null ? AssistantMethods.readCurrentOnlineUserInfo() : null;

    Timer(const Duration(seconds: 3), () async{

      if(await fAuth.currentUser != null){
        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(context, MaterialPageRoute(builder: (c)=> MainScreen()));
      }
      else {
        //send user to main screen
        Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
      }

    });
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
        ],
      ),
    );
  }
}
