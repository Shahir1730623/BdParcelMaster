import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:driver/models/driver_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

import '../models/driver_data.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;

DriverModel? driverModelCurrentInfo;

Position? driverCurrentPosition;

DriverData onlineDriverData = DriverData();

StreamSubscription<Position>? streamSubscriptionPosition;
StreamSubscription<Position>? streamSubscriptionDriverLivePosition;

String titleStarsRating = "Good";

AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();