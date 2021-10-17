// // ignore_for_file: prefer_const_constructors
// import 'package:flutter/material.dart';
// import '../authenticate/login_screen.dart';
// import '../authenticate/signup_screen.dart';
//
//
// //splash screen to either create account or log In
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue[50],
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Welcome to Rent Tech!"),
//             RaisedButton(
//                 child: Text('Create Account'),
//                 onPressed: () {
//                  Navigator.push(context, new MaterialPageRoute(builder: (context) => new SignupScreen()));
//                 }),
//             Text('Already have an account?'),
//             RaisedButton(
//                 child: Text('Login'),
//                 onPressed: () {
//                   Navigator.push(context, new MaterialPageRoute(builder: (context) => new LoginScreen()));
//                 }),
//           ],
//         ),
//       ),
//     );
//   }
// }
