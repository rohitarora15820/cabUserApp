import 'package:flutter/material.dart';

import '../global/global.dart';
import '../splashSceen/splash_screen.dart';

class ProfileTabScreen extends StatelessWidget {
  const ProfileTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: ElevatedButton(
              onPressed: () {
                fauth.signOut();
                Navigator.push(context, MaterialPageRoute(builder: ((c) {
                  return const MySplashScreen();
                })));
              },
              child: Text('Sign Out'))),
    );
  }
}
