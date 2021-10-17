import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_tech/screens/wrapper.dart';
import 'package:rent_tech/authenticate/fire_auth.dart';


import 'authenticate/fire_auth.dart';
import 'models/myuser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
      return StreamProvider<MyUser?>.value(
        catchError: (_,__) => null,
        value: AuthService().user,
        initialData: null,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Rent Tech',
          home: Wrapper(),
        ),
      );

  }
}

