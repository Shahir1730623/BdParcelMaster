import 'dart:async';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:users/mainScreens/dashboard_home.dart';

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

    //AssistantMethods.readCurrentOnlineUserInfo();

    AssistantMethods.readTripsKeysForOnlineUser(context);

    Timer(const Duration(seconds: 3), () async{

      if(await fAuth.currentUser != null){
        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(context, MaterialPageRoute(builder: (c)=> DashboardHome()));
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
          Container(
            margin: EdgeInsets.only(top: 120, left: 50),
              child: Image.asset(
                  'images/logo.png',
                width: 300,
              ),
          ),
          Container(
            margin: EdgeInsets.only(top: 420, left: 50),
            child: Text(
              "Bd Parcel Master",
              style: TextStyle(
                fontSize: 40,
                color: Color(0xffe98f60),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
