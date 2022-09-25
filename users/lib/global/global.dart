import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

import '../mainScreens/user_model.dart';
import '../models/direction_details_info.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;

UserModel? userModelCurrentInfo;
List dList = []; //online/active drivers Info List

DirectionDetailsInfo? tripDirectionDetailsInfo;
String? choosendriverId = "";
String cloudMessagingServerToken = "key=AAAAEGrp4ks:APA91bHPPcy0i1P3ZScVFwGJiL_TPLrLUemhj4licX2WGAkdXOKtm0pfKJ5kCN8l92fvSleHju4eN8UPcp7cV2cxG3mlMHlwXwrcSFJyrpW9qaMv2pxchgwv0lQhvhEmxEbjuTyIVzs2";
Position? driverCurrentPosition;
String driverCarDetails = "";
String driverName = "";
String driverPhone = "";
double countRatingStars = 0.0;
String titleStarsRating = "";
StreamSubscription<Position>? streamSubscriptionPosition;

String userDropOffAddress = "";