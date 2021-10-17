import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_tech/authenticate/authenticate.dart';
import 'package:rent_tech/homescreen/home_screen.dart';
import 'package:rent_tech/models/myuser.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);


    if (user == null){
      return Authenticate();
    } else {
      return HomeScreen();
    }
  }
}
