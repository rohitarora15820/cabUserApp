import 'package:cabuserapp/authentication/signUp_screen.dart';
import 'package:cabuserapp/global/global.dart';
import 'package:cabuserapp/splashSceen/splash_screen.dart';
import 'package:cabuserapp/widgets/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailEditingController = TextEditingController();

  TextEditingController passwordEditingController = TextEditingController();

  validateForm() {
    if (!emailEditingController.text.contains('@')) {
      Fluttertoast.showToast(msg: "Please enter a valid email address");
    } else if (passwordEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "password is required");
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
            .signInWithEmailAndPassword(
                email: emailEditingController.text,
                password: passwordEditingController.text)
            .catchError((msg) {
      Navigator.pop(context);

      Fluttertoast.showToast(msg: "Error: $msg");
    }))
        .user;

    if (firebaseUser != null) {
      currentUser = firebaseUser;
      Fluttertoast.showToast(msg: "Login Successfully");
      Navigator.push(
          context, MaterialPageRoute(builder: ((c) => MySplashScreen())));
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Login failed");
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
              "Login as a User",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
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
                  'Login',
                  style: TextStyle(color: Colors.black54, fontSize: 18),
                )),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((c) => SignUpScreen())));
              },
              child: Text(
                'Do not have an account? Register here',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
