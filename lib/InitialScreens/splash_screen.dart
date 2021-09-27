import 'package:flutter/material.dart';
import 'package:rent_tech/utils/route_generator.dart';
//splash screen to either create account or log In
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to Rent Tech!"),
            RaisedButton(
                child: Text('Create Account'),
                onPressed: null),
            Text('Already have an account?'),
            RaisedButton(
                child: Text('Login'),
                onPressed: (){
                  Navigator.of(context).pushNamed('/login');
                }
            ),

          ],
        ),
      ),
    );


  }
}