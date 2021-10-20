import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rent_tech/authenticate/fire_auth.dart';
import 'package:rent_tech/displaya_all_products/allproducts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(

          backgroundColor: Colors.white,
          title: Text("Tech to Rent",style: TextStyle(
            color: Colors.black,
          ),),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
        body: Center(
          child: Center(
            child: Text("This is the homescreen?"),
          ),

        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: (){
            Navigator.push(context, new MaterialPageRoute(builder: (context) => AllProducts()));
          },
          child: Icon(Icons.check),
        ),
      ),
    );
  }
}
