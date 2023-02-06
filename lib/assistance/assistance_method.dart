import 'package:cabuserapp/global/global.dart';
import 'package:cabuserapp/models/user_model.dart';
import 'package:firebase_database/firebase_database.dart';

class AssistanceMethod {
  static void getUserData() {
    currentUser = fauth.currentUser;
    DatabaseReference dref =
        FirebaseDatabase.instance.ref().child("users").child(currentUser!.uid);

    dref.once().then((snap) {
      if (snap.snapshot.value != null) {
        currentUserModelInfo = UserModel.fromSnapshot(snap.snapshot);
        print(currentUserModelInfo!.name.toString());
      } else {
        print("user data not found");
      }
    });
  }
}
