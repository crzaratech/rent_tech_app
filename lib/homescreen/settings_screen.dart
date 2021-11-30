import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_tech/authenticate/fire_auth.dart';

class userSettings extends StatefulWidget {
  String? uid;

  userSettings({Key? key, @required this.uid}) : super(key: key);
  @override
  _userSettings createState() => _userSettings();
}

class _userSettings extends State<userSettings> {
  Widget EditEmailBttn() {
    return Center(
        child: Column(
      children: <Widget>[
        OutlinedButton(onPressed: () => {}, child: Text('Edit Email'))
      ],
    ));
  }

  Widget EditPasswordBttn() {
    return Center(
        child: Column(
      children: <Widget>[
        OutlinedButton(onPressed: () => {}, child: Text('Edit Password'))
      ],
    ));
  }

  Widget LogOutBttn() {
    return Center(
        child: Column(
      children: <Widget>[
        ElevatedButton(
          key: Key('logout-btn'),
          onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text('Log out'),
                    content: const Text('Are you sure you want to log out?'),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel')),
                      TextButton(
                        key: Key('logout-ok-btn'),
                          onPressed: () async {
                            Navigator.pop(context, 'OK');
                            await FirebaseAuth.instance.signOut();
                          },
                          child: const Text('Log out'))
                    ],
                  )),
          child: const Text('Logout'),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Text('nothing');
  }
}

// Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         const SizedBox(height: 20),
//         Container(
//           alignment: Alignment.center,
//           height: 80,
//           width: 400,
//           padding: EdgeInsets.all(15),
//           child: TextField(
//               decoration: InputDecoration(
//             border: OutlineInputBorder(),
//             labelText: 'Email',
//             enabled: false,
//           )),
//         ),
//         const SizedBox(height: 10),
//         EditEmailBttn(),
//         const SizedBox(height: 10),
//         Container(
//           alignment: Alignment.center,
//           height: 80,
//           width: 400,
//           padding: EdgeInsets.all(15),
//           child: TextField(
//               obscureText: true,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Password',
//                 enabled: false,
//               )),
//         ),
//         const SizedBox(height: 10),
//         EditPasswordBttn(),
//         const SizedBox(height: 20),
//         LogOutBttn(),
//       ],
//     );