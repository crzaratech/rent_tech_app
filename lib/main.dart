import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rent_tech/InitialScreens/splash_screen.dart';

import 'package:rent_tech/UI/appthemedata.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _initialization,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Center(
                  child: Text("working?"),
                ),
              ),
            ),
          );

        }else if(snapshot.hasError){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
            body: Center(
              child: Center(
                child: Text("An error accorred :("),
              ),
            ),
            ),
          );
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Rent Tech',

          theme: CustomTheme.lightTheme,

          home: SplashScreen(),

        );

        },

    );


  }
}


