import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:rent_tech/authenticate/fire_auth.dart';
import 'package:rent_tech/display_all_products/allproducts.dart';
import 'package:rent_tech/productScreens/accessoriesForRent.dart';
import 'package:rent_tech/productScreens/desktopsForRent.dart';
import 'package:rent_tech/productScreens/laptopsForRent.dart';
import 'package:rent_tech/display_all_products/upload_product.dart';
import 'package:rent_tech/homescreen/scoll_products.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _auth = AuthService();
  int _currentIndex = 0;

  final tabs = [
    Center(child: ProductTypes()),
    Center(child: AllProducts()),
    Center(child: uploadProduct()),
    Center(child: Text('Setting')),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Tech to Rent",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              label: Text(
                'logout',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.blueGrey,
            selectedItemColor: Colors.lightBlueAccent,

            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.border_all_rounded), label: 'All Products'),
              BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: 'Add Product'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            }),
        body: tabs[_currentIndex],
      ),
    );
  }
}
