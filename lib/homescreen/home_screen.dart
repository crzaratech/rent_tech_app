import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:rent_tech/authenticate/fire_auth.dart';
import 'package:rent_tech/displaya_all_products/allproducts.dart';
import 'package:rent_tech/productScreens/accessoriesForRent.dart';
import 'package:rent_tech/productScreens/desktopsForRent.dart';
import 'package:rent_tech/productScreens/laptopsForRent.dart';
import 'package:rent_tech/displaya_all_products/upload_product.dart';

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
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle), label: 'Add Product'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ]),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Rent",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    height: 220,
                    width: double.maxFinite,
                    child: Card(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllProducts()));
                        },
                        child: Image.asset('assets/laptop.png'),
                        //elevation: 5,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 1, 20, 1),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Laptops",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 1, 20, 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "2 items",
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 14),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    height: 220,
                    width: double.maxFinite,
                    child: Card(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllProducts()));
                        },
                        child: Image.asset('assets/desktop.png',
                            fit: BoxFit.cover),
                        //elevation: 5,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 1, 20, 1),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Desktops",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 1, 20, 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "5 items",
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 14),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    height: 220,
                    width: double.maxFinite,
                    child: Card(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllProducts()));
                        },
                        child: Image.asset('assets/accessories.png',
                            fit: BoxFit.cover),
                        //elevation: 5,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 1, 20, 1),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Accessories",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 1, 20, 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "3 items",
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 14),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
