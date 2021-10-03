import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

        ),
        body: Center(
          child: Center(
            child: Text("This is the homescreen?"),
          ),
        ),
      ),
    );
  }
}
