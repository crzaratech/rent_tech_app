import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class userSettings extends StatefulWidget {
  @override
  _userSettings createState() => _userSettings();
}

class _userSettings extends State<userSettings> {
  Widget LogOutBttn() {
    return Center(
        child: Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text('Log out'),
                    content: const Text('Are you sure you want to log out?'),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () => {}, child: const Text('Cancel')),
                      TextButton(
                          onPressed: () async {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.centerLeft,
          height: 60,
          child: const TextField(
              decoration: InputDecoration(
                  enabled: false,
                  contentPadding: EdgeInsets.all(20),
                  prefixIcon: Icon(Icons.supervised_user_circle_outlined,
                      color: Color(0xff00bfff)),
                  hintText: 'Edit Name',
                  hintStyle: TextStyle(
                    color: Colors.black38,
                  ))),
        ),
        const SizedBox(height: 10),
        LogOutBttn(),
      ],
    );
  }
}
