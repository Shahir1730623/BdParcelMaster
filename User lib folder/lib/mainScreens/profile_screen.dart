import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:users/global/global.dart';
import 'package:users/mainScreens/dashboard_home.dart';
import 'package:users/mainScreens/edit_profile_page.dart';

import '../widgets/appbar_widget.dart';
import '../widgets/button_widget.dart';
import '../widgets/profile_widget.dart';


class ProfileScreen extends StatefulWidget
{
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      //appBar: buildAppBar(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.backspace,
            color: Colors.red,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (c) => DashboardHome()));
          },
        ),

      ),
      body: ListView(
        children: [
          ProfileWidget(
            imagePath: 'https://firebasestorage.googleapis.com/v0/b/bdparcelmaster-71a1b.appspot.com/o/users%2F${currentFirebaseUser!.uid}%2Fpro-pic.png?alt=media&token=02b982af-2abb-467a-9291-c0979fc7f445',
            onClicked: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) => EditProfilePage()));
            },
          ),

          const SizedBox(height: 24),

          Column(
            children: [
              Text(
                userModelCurrentInfo!.name!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 4),
              Text(
                userModelCurrentInfo!.email!,
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
          const SizedBox(height: 24),

          Center(child: ButtonWidget(
            text: 'Change Name & Password',
            onClicked: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (context) => EditProfilePage()),
              // );
            },
          ),
          ),
          const SizedBox(height: 24),

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
                  userModelCurrentInfo!.phone!,
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
                //Geofire.removeLocation(currentFirebaseUser!.uid);

                // DatabaseReference? ref = FirebaseDatabase.instance.ref()
                //     .child("users")
                //     .child(currentFirebaseUser!.uid);
                //
                // ref.onDisconnect();
                // ref.remove();
                // ref = null;

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
