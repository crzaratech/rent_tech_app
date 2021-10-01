// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rent_tech/InitialScreens/signup_screen.dart';
import 'package:rent_tech/InitialScreens/forgotpassword_screen.dart';
import 'package:rent_tech/homescreen/home_screen.dart';


class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isRememberMe = false;
  Widget buildEmail() {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(Icons.email, color: Color(0xff00bfff)),
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    color: Colors.black38,
                  ))),
        )
      ],
    );
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextField(
              obscureText: true,
              style: TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(Icons.lock, color: Color(0xff00bfff)),
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Colors.black38,
                  ))),
        )
      ],
    );
  }

  Widget buildForgotPassBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {
          Navigator.push(context, new MaterialPageRoute(builder: (context) => new Forgotscreen()));
        },
        padding: EdgeInsets.only(right: 0),
        child: Text(
          'Forgot password',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildRememberMe() {
    return Container(
        height: 20,
        child: Row(
          children: <Widget>[
            Theme(
              data: ThemeData(unselectedWidgetColor: Colors.white),
              child: Checkbox(
                value: isRememberMe,
                checkColor: Colors.blue,
                activeColor: Colors.white,
                onChanged: (value) {
                  setState(() {
                    isRememberMe = value!;
                  });
                },
              ),
            ),
            Text(
              'Remember me',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }

  Widget buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));

        },
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white,
        child: Text(
          'Login',
          style: TextStyle(
              color: Color(0xff00bfff),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildSignUpBtn() {
    return GestureDetector(
      onTap: () {
         Navigator.push(context, new MaterialPageRoute(builder: (context) => new SignupScreen()));
      },
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: 'Don\'t have an Accout?',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
          TextSpan(
              text: ' Sign up',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold))
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color(0x6600bfff),
                      Color(0x9900bfff),
                      Color(0xff00bfff),
                      Color(0xff00bfff),
                    ])),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 120,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Sign In',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 50),
                      buildEmail(),
                      SizedBox(height: 20),
                      buildPassword(),
                      buildForgotPassBtn(),
                      buildRememberMe(),
                      buildLoginBtn(),
                      buildSignUpBtn(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
