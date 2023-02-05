import 'dart:async';

import 'package:cabuserapp/global/global.dart';
import 'package:flutter/material.dart';

import '../authentication/login_screen.dart';
import '../mainscreens/main_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 3), () async {
      if (fauth.currentUser != null) {
        currentUser = fauth.currentUser;
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const MainScreen();
          },
        ));
      } else {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        ));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png'),
            SizedBox(
              height: 10,
            ),
            Text(
              'Uber & inDrive App',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
