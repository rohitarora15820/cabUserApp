import 'package:cabuserapp/authentication/login_screen.dart';
import 'package:cabuserapp/global/global.dart';
import 'package:cabuserapp/splashSceen/splash_screen.dart';
import 'package:cabuserapp/widgets/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  validateForm() {
    if (nameEditingController.text.length < 3) {
      Fluttertoast.showToast(msg: "name must be at least 3 characters");
    } else if (!emailEditingController.text.contains('@')) {
      Fluttertoast.showToast(msg: "Please enter a valid email address");
    } else if (phoneEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Phone No is required");
    } else if (phoneEditingController.text.length < 10) {
      Fluttertoast.showToast(msg: "phone must be at least 10 characters");
    } else if (passwordEditingController.text.length < 6) {
      Fluttertoast.showToast(msg: "password must be at least 3 characters");
    } else {
      saveDriverInfo();
    }
  }

  saveDriverInfo() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c) {
        return ProgressDialog(
          message: "Processing , Please wait...",
        );
      },
    );

    final User? firebaseUser = (await fauth
            .createUserWithEmailAndPassword(
                email: emailEditingController.text.trim(),
                password: passwordEditingController.text.trim())
            .catchError((msg) {
      Navigator.pop(context);

      Fluttertoast.showToast(msg: "Error: $msg");
    }))
        .user;

    if (firebaseUser != null) {
      Map userMap = {
        "id": firebaseUser.uid,
        "name": nameEditingController.text.trim(),
        "email": emailEditingController.text.trim(),
        "phone": phoneEditingController.text.trim(),
      };

      DatabaseReference fRef = FirebaseDatabase.instance.ref().child("users");
      fRef.child(firebaseUser.uid).set(userMap);
      currentUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been created");
      Navigator.push(
          context, MaterialPageRoute(builder: ((c) => MySplashScreen())));
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account has not been created");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset('assets/logo.png'),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Register as a User",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: nameEditingController,
              style: const TextStyle(color: Colors.grey),
              decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "Name",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailEditingController,
              style: const TextStyle(color: Colors.grey),
              decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
            ),
            TextField(
              keyboardType: TextInputType.phone,
              controller: phoneEditingController,
              style: const TextStyle(color: Colors.grey),
              decoration: const InputDecoration(
                  labelText: "Phone",
                  hintText: "Phone",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
            ),
            TextField(
              keyboardType: TextInputType.text,
              obscureText: true,
              controller: passwordEditingController,
              style: const TextStyle(color: Colors.grey),
              decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  validateForm();
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: ((c) => CarInfoScreen())));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreenAccent),
                child: const Text(
                  'Create Account',
                  style: TextStyle(color: Colors.black54, fontSize: 18),
                )),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((c) => LoginScreen())));
                },
                child: Text(
                  'Already have an account? Login Here',
                  style: TextStyle(color: Colors.grey),
                )),
          ],
        ),
      )),
    );
  }
}
