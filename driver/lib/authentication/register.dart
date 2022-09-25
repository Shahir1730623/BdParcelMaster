import 'package:driver/authentication/background.dart';
import 'package:driver/authentication/login_screen.dart';
import 'package:driver/splashScreen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/global.dart';
import '../widgets/progress_dialog.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm(){

    if(nameTextEditingController.text.length < 3){
      Fluttertoast.showToast(msg: "name must be at least 3 characters");
    }
    else if(!emailTextEditingController.text.contains("@")){
      Fluttertoast.showToast(msg: "Email address is not valid");
    }
    else if(phoneTextEditingController.text.isEmpty){
      Fluttertoast.showToast(msg: "Phone number is required");
    }
    else if(passwordTextEditingController.text.length < 6){
      Fluttertoast.showToast(msg: "Password must be atleast 6 characters");
    }
    else{
      saveDriverInfoNow();
    }
  }

  saveDriverInfoNow() async{

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c){
          return ProgressDialog(message: "Processing, Please wait...",);
        }
    );

    final User? firebaseUser = (
        await fAuth.createUserWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: " + msg.toString());
        })
    ).user;

    if(firebaseUser != null){
      Map driverMap = {
        "id": firebaseUser.uid,
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
        "pro-pic": "user.png",
      };

      DatabaseReference driverRef = FirebaseDatabase.instance.ref().child("drivers");
      driverRef.child(firebaseUser.uid).set(driverMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been created");
      Navigator.push(context, MaterialPageRoute(builder: (c) => MySplashScreen()));
    }
    else{
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account has not been created ");
    }
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
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
                  "Register",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    Container(
                      height: 200,
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
                              controller: nameTextEditingController,
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(fontSize: 20),
                                border: InputBorder.none,
                                icon: Icon(Icons.account_circle_rounded),
                                hintText: "Name",
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 16, right: 32),
                            child: TextField(
                              controller: emailTextEditingController,
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
                              controller: phoneTextEditingController,
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(fontSize: 20),
                                border: InputBorder.none,
                                icon: Icon(Icons.account_circle_rounded),
                                hintText: "Phone Number",
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 16, right: 32),
                            child: TextField(
                              controller: passwordTextEditingController,
                              obscureText: true,
                              decoration: const InputDecoration(
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
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
                    },
                    child: const Text(
                      "Login Here",
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
