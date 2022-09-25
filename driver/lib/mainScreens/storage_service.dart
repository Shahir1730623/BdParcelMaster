import 'dart:convert';
import 'dart:io';

import 'package:driver/global/global.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;


  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);

    try{
      await storage.ref('users/${currentFirebaseUser!.uid}/pro-pic.png').putFile(file);
      FirebaseDatabase.instance.ref().child("drivers").child(currentFirebaseUser!.uid).child("pro-pic").set("pro-pic.png");
    } on firebase_core.FirebaseException catch (e){
      print(e);
    }
  }

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult results = await storage.ref('users/${currentFirebaseUser!.uid}').listAll();

    results.items.forEach((firebase_storage.Reference ref) {
      print('Found file: $ref');
    });
    return results;
  }

  Future<String> downloadURL(String imageName) async {
    String downloadURL = await storage.ref('users/${currentFirebaseUser!.uid}/$imageName').getDownloadURL();

    String url = downloadURL.toString();
    print("This is url");
    print(url);

    print(downloadURL);

    return downloadURL;
  }


}