import 'package:firebase_database/firebase_database.dart';

class UserModel {
  String? name;
  String? email;
  String? id;
  String? phone;

  UserModel({this.name, this.email, this.id, this.phone});

  UserModel.fromSnapshot(DataSnapshot snap) {
    name = (snap.value as dynamic)["name"];
    email = (snap.value as dynamic)["email"];
    id = snap.key;
    phone = (snap.value as dynamic)["phone"];
  }
}
