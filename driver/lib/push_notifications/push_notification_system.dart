

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:driver/global/global.dart';
import 'package:driver/models/user_ride_request_information.dart';
import 'package:driver/push_notifications/notification_dialog_box.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PushNotificationSystem{
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future initializeCloudMessaging(BuildContext context) async
  {
    //1. Terminated
    //When the app is completely closed and opened directly from the push notification
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? remoteMessage){
      if(remoteMessage != null){
        // print("This is Ride Request Id: ");
        // print(remoteMessage.data["rideRequestId"]);
        //display ride request information - user information who request a ride
        readUserRideRequestInformation(remoteMessage.data["rideRequestId"], context);

      }
    });

    //2. Foreground
    //When the app is open and it receives a push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      // print("This is Ride Request Id: ");
      // print(remoteMessage!.data["rideRequestId"]);
      //display ride request information - user information who request a ride
      readUserRideRequestInformation(remoteMessage!.data["rideRequestId"], context);
    });

    //3. Background
    //When the app is in the background and opened directly from the push notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      // print("This is Ride Request Id: ");
      // print(remoteMessage!.data["rideRequestId"]);
      //display ride request information - user information who request a ride
      readUserRideRequestInformation(remoteMessage!.data["rideRequestId"], context);
    });
  }

  readUserRideRequestInformation(String userRideRequestId, BuildContext context) {
    FirebaseDatabase.instance.ref()
        .child("All Ride Requests")
        .child(userRideRequestId)
        .once()
        .then((snapData)
    {
      if(snapData.snapshot.value != null){

        audioPlayer.open(Audio("music/music_notification.mp3"));
        audioPlayer.play();

        double originLat = double.parse((snapData.snapshot.value! as Map)["origin"]["latitude"]);
        double originLng = double.parse((snapData.snapshot.value! as Map)["origin"]["longitude"]);
        String originAddress = (snapData.snapshot.value! as Map)["originAddress"];

        double destinationLat = double.parse((snapData.snapshot.value! as Map)["destination"]["latitude"]);
        double destinationLng = double.parse((snapData.snapshot.value! as Map)["destination"]["longitude"]);
        String destinationAddress = (snapData.snapshot.value! as Map)["destinationAddress"];

        String userName = (snapData.snapshot.value! as Map)["userName"];
        String userPhone = (snapData.snapshot.value! as Map)["userPhone"];

        String receiverName = (snapData.snapshot.value! as Map)["receiverName"];
        String receiverAddress = (snapData.snapshot.value! as Map)["receiverAddress"];
        String receiverCountry = (snapData.snapshot.value! as Map)["receiverCountry"];
        String weight = (snapData.snapshot.value! as Map)["weight"];
        String amount = (snapData.snapshot.value! as Map)["amount"];

        String? rideRequestId = snapData.snapshot.key;

        UserRideRequestInformation userRideRequestDestails = UserRideRequestInformation();
        userRideRequestDestails.originLatLng = LatLng(originLat, originLng);
        userRideRequestDestails.originAddress = originAddress;
        userRideRequestDestails.destinationLatLng = LatLng(destinationLat, destinationLng);
        userRideRequestDestails.destinationAddress = destinationAddress;
        userRideRequestDestails.userName = userName;
        userRideRequestDestails.userPhone = userPhone;

        userRideRequestDestails.receiverName = receiverName;
        userRideRequestDestails.receiverAddress = receiverAddress;
        userRideRequestDestails.receiverCountry = receiverCountry;
        userRideRequestDestails.weight = weight;
        userRideRequestDestails.amount = amount;

        userRideRequestDestails.rideRequestId = rideRequestId;

        // print("This is user Ride Request Information: ");
        // print(userRideRequestDestails.userName);
        // print(userRideRequestDestails.userPhone);
        showDialog(
            context: context,
            builder: (BuildContext context) => NotificationDialogBox(
                userRideRequestDetails: userRideRequestDestails),
        );
      }
      else {
        Fluttertoast.showToast(msg: "This Ride Request Id do not exists.");
      }
    });
  }

  Future generateAndGetToken() async {
    String? registrationToken = await messaging.getToken();
    print("FCM registration Token: ");
    print(registrationToken);

    FirebaseDatabase.instance.ref()
        .child("drivers")
        .child(currentFirebaseUser!.uid)
        .child("token")
        .set(registrationToken);

    messaging.subscribeToTopic("allDrivers");
    messaging.subscribeToTopic("allUsers");
  }


}