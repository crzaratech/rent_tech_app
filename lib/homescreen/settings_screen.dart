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
  AuthService currentUser = AuthService();
  final emailController = TextEditingController();
  final pwdController = TextEditingController();
  void updateEmail() {
    currentUser.updateCurrentUserEmail(emailController.text);
  }

  void updatePassword() {
    currentUser.updateCurrentUserPassword(pwdController.text);
  }

  Widget EditEmailBttn() {
    return Center(
        child: Column(
      children: <Widget>[
        OutlinedButton(
            onPressed: () {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                          title: const Text('Update email'),
                          content: const Text(
                              'Are you sure you want to update your email?'),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () => {Navigator.pop(context, 'No')},
                                child: const Text('No')),
                            TextButton(
                                onPressed: () =>
                                    {Navigator.pop(context, 'Yes')},
                                child: const Text('Yes'))
                          ]));
            },
            child: const Text('Edit Email'))
      ],
    ));
  }

  Widget EditPasswordBttn() {
    return Center(
        child: Column(
      children: <Widget>[
        OutlinedButton(
            onPressed: () {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                          title: const Text('Update Password'),
                          content: const Text(
                              'Are you sure you want to update your password?'),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () => {Navigator.pop(context, 'No')},
                                child: const Text('No')),
                            TextButton(
                                onPressed: () =>
                                    {Navigator.pop(context, 'Yes')},
                                child: const Text('Yes'))
                          ]));
            },
            child: const Text('Edit Password'))
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
    var email = currentUser.getCurrentUserEmail();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          height: 80,
          width: 400,
          padding: EdgeInsets.all(15),
          child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '$email',
                enabled: true,
              )),
        ),
        const SizedBox(height: 10),
        EditEmailBttn(),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.center,
          height: 80,
          width: 400,
          padding: EdgeInsets.all(15),
          child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                enabled: false,
              )),
        ),
        const SizedBox(height: 10),
        EditPasswordBttn(),
        const SizedBox(height: 20),
        LogOutBttn(),
      ],
    );
  }
}
