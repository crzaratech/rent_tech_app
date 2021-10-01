// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rent_tech/InitialScreens/login_screen.dart';
import 'package:rent_tech/homescreen/home_screen.dart';
import 'package:rent_tech/utils/fire_auth.dart';
class SignupScreen extends StatefulWidget {

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  late TextEditingController _fullNameController = TextEditingController(text: '');
  late TextEditingController _emailController = TextEditingController(text: '');
  late TextEditingController _pwController = TextEditingController(text: '');


  bool isRememberMe = false;
  Widget buildName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Full Name',
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
              controller: _fullNameController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(Icons.person, color: Color(0xff00bfff)),
                  hintText: 'Full Name',
                  hintStyle: TextStyle(
                    color: Colors.black38,
                  ))),
        )
      ],
    );
  }

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
            controller: _emailController,
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
            controller: _pwController,
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

  // Widget buildPhoneNumber() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Text(
  //         'Phone Number',
  //         style: TextStyle(
  //             color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
  //       ),
  //       SizedBox(height: 10),
  //       Container(
  //         alignment: Alignment.centerLeft,
  //         decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(10),
  //             boxShadow: [
  //               BoxShadow(
  //                   color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
  //             ]),
  //         height: 60,
  //         child: TextField(
  //             obscureText: true,
  //             style: TextStyle(color: Colors.black87),
  //             decoration: InputDecoration(
  //                 border: InputBorder.none,
  //                 contentPadding: EdgeInsets.only(top: 14),
  //                 prefixIcon: Icon(Icons.phone, color: Color(0xff00bfff)),
  //                 hintText: 'Phone Number',
  //                 hintStyle: TextStyle(
  //                   color: Colors.black38,
  //                 ))),
  //       )
  //     ],
  //   );
  // }

  // Widget buildRememberMe() {
  //   return Container(
  //       height: 20,
  //       child: Row(
  //         children: <Widget>[
  //           Theme(
  //             data: ThemeData(unselectedWidgetColor: Colors.white),
  //             child: Checkbox(
  //               value: isRememberMe,
  //               checkColor: Colors.blue,
  //               activeColor: Colors.white,
  //               onChanged: (value) {
  //                 setState(() {
  //                   isRememberMe = value;
  //                 });
  //               },
  //             ),
  //           ),
  //           Text(
  //             'Remember me',
  //             style:
  //                 TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  //           ),
  //         ],
  //       ));
  // }

  Widget buildSignUpBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,

        onPressed: () async {
          try{
            await _auth.createUserWithEmailAndPassword(
                email: _emailController.text.trim().toLowerCase(),
                password: _pwController.text.trim(),
            );
            final User? user = _auth.currentUser;
            final _uid = user!.uid;
            FirebaseFirestore.instance.collection('users').doc(_uid).set({
              'id:' :_uid,
              'name': _fullNameController.text,
              'email':_emailController.text,
              'createdAt':Timestamp.now(),
            });
            Navigator.canPop(context) ? Navigator.pop(context): null;



          } catch(error){
            print(error);
          }

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));

        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: Text(
          'Signup',
          style: TextStyle(
              color: Color(0xff00bfff),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildLoginBtn() {
    return GestureDetector(
      onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => LoginScreen())),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: 'Already have an Account?',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
          TextSpan(
              text: ' Log in',
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
                        'Sign up',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 50),
                      buildName(),
                      SizedBox(height: 10),
                      //buildPhoneNumber(),
                      SizedBox(height: 10),
                      buildEmail(),
                      SizedBox(height: 10),
                      buildPassword(),
                      //buildRememberMe(),
                      buildSignUpBtn(),
                      buildLoginBtn(),
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