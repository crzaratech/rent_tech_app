import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rent_tech/displaya_all_products/allproducts.dart';
import 'package:rent_tech/displaya_all_products/allproducts.dart';
import 'package:rent_tech/productScreens/accessoriesForRent.dart';
import 'package:rent_tech/productScreens/desktopsForRent.dart';
import 'package:rent_tech/productScreens/laptopsForRent.dart';

class ProductTypes extends StatefulWidget {
  @override
  _ProductTypes createState() => _ProductTypes();
}

class _ProductTypes extends State<ProductTypes> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 1, 20, 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "2 items",
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
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
                    child: Image.asset('assets/desktop.png', fit: BoxFit.cover),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 1, 20, 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "5 items",
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 1, 20, 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "3 items",
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
