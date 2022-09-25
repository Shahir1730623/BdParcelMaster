import 'dart:io';

import 'package:driver/tabPages/home_tab.dart';
import 'package:driver/tabPages/home_tab.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geofire/flutter_geofire.dart';


import '../global/global.dart';
import '../mainScreens/edit_profile_page.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/button_widget.dart';
import '../widgets/profile_widget.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({Key? key}) : super(key: key);

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: buildAppBar(context),
          body: ListView(
            //physics: BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                imagePath: 'https://firebasestorage.googleapis.com/v0/b/bdparcelmaster-71a1b.appspot.com/o/users%2F${currentFirebaseUser!.uid}%2Fpro-pic.png?alt=media&token=02b982af-2abb-467a-9291-c0979fc7f445',
                onClicked: () {

                },
              ),

              const SizedBox(height: 24),

              Column(
                children: [
                  Text(
                    driverModelCurrentInfo!.name!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    driverModelCurrentInfo!.email!,
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
              const SizedBox(height: 24),

              Center(child: ButtonWidget(
                  text: 'Change Name & Password',
                  onClicked: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => EditProfilePage()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              //NumbersWidget(),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Phone Number',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      driverModelCurrentInfo!.phone!,
                      style: TextStyle(fontSize: 16, height: 1.4),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: ()
                  {
                    Geofire.removeLocation(currentFirebaseUser!.uid);

                    DatabaseReference? ref = FirebaseDatabase.instance.ref()
                        .child("drivers")
                        .child(currentFirebaseUser!.uid)
                        .child("newRideStatus");

                    ref.onDisconnect();
                    ref.remove();
                    ref = null;

                    fAuth.signOut();
                    SystemNavigator.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent,
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        );
  }
}
