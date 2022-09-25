import 'package:driver/authentication/background.dart';
import 'package:driver/authentication/register.dart';
import 'package:driver/splashScreen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/global.dart';
import '../widgets/progress_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm(){
    if(!emailTextEditingController.text.contains("@")){
      print(emailTextEditingController);
      Fluttertoast.showToast(msg: "Email address is not valid");
    }
    else if(passwordTextEditingController.text.isEmpty){
      Fluttertoast.showToast(msg: "Password is required");
    }
    else{
      loginDriverNow();
    }
  }

  loginDriverNow() async{
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c){
          return ProgressDialog(message: "Logging in, Please wait...",);
        }
    );

    final User? firebaseUser = (
        await fAuth.signInWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: " + msg.toString());
        })
    ).user;

    if(firebaseUser != null){

      DatabaseReference driverRef = FirebaseDatabase.instance.ref().child("drivers");
      driverRef.child(firebaseUser.uid).once().then((driverKey){
        final snap = driverKey.snapshot;
        if(snap.value != null){
          currentFirebaseUser = firebaseUser;
          Fluttertoast.showToast(msg: "Login Successful");
          Navigator.push(context, MaterialPageRoute(builder: (c) => MySplashScreen()));
        }
        else{
          Fluttertoast.showToast(msg: "No record exist with this email.");
          fAuth.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (c) => MySplashScreen()));
        }
      });
    }
    else{
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error occured during login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 60),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 150,
                child: Stack(
                  children: [
                    Container(
                      height: 150,
                      margin: const EdgeInsets.only(
                        right: 70,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(100),
                          bottomRight: Radius.circular(100),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 16, right: 32),
                            child: TextField(
                              controller: emailTextEditingController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(fontSize: 20),
                                border: InputBorder.none,
                                icon: Icon(Icons.account_circle_rounded),
                                hintText: "Email",
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 16, right: 32),
                            child: TextField(
                              controller: passwordTextEditingController,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(fontSize: 22),
                                border: InputBorder.none,
                                icon: Icon(Icons.account_circle_rounded),
                                hintText: "********",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Container(
                          height: 80,
                          width: 80,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xff22e2ab),
                                shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(50.0),
                              ),
                            ),
                            onPressed: () {
                              //Navigator.push(context, MaterialPageRoute(builder: (c)=> MySplashScreen()));
                              validateForm();
                            },
                            child: const Icon(
                              Icons.arrow_forward_outlined,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 16, top: 16),
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (c)=> Register()));
                      },
                      child: Text(
                        "Doesn't have account? Register Here",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffe98f60),
                        ),
                      ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
