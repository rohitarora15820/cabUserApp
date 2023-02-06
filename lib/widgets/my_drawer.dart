import 'package:cabuserapp/global/global.dart';
import 'package:cabuserapp/splashSceen/splash_screen.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  final String? name;
  final String? email;
  const MyDrawer({super.key, this.name, this.email});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          //drawer header
          Container(
              height: 165,
              color: Colors.grey,
              child: DrawerHeader(
                  decoration: const BoxDecoration(color: Colors.black),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: 80,
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.name.toString(),
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.email.toString(),
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ))),
          const SizedBox(
            height: 14,
          ),

          //drawer body
          GestureDetector(
            onTap: () {},
            child: const ListTile(
              leading: Icon(
                Icons.history,
                color: Colors.white54,
              ),
              title: Text(
                'History',
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.white54,
              ),
              title: Text(
                'View Profile',
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const ListTile(
              leading: Icon(
                Icons.info,
                color: Colors.white54,
              ),
              title: Text(
                'About',
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              fauth.signOut();
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const MySplashScreen();
                },
              ));
            },
            child: const ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.white54,
              ),
              title: Text(
                'Sign Out',
                style: TextStyle(color: Colors.white54),
              ),
            ),
          )
        ],
      ),
    );
  }
}
