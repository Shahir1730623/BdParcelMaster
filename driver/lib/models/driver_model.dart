
import 'package:driver/global/global.dart';
import 'package:firebase_database/firebase_database.dart';

class DriverModel{
  String? id;
  String? name;
  String? email;
  String? phone;

  DriverModel({
    this.id,
    this.name,
    this.email,
    this.phone,
  });

  DriverModel.fromSnapshot(DataSnapshot snap){
    id = snap.key;
    name = (snap.value as dynamic)["name"];
    email = (snap.value as dynamic)["email"];
    phone = (snap.value as dynamic)["phone"];
  }

}