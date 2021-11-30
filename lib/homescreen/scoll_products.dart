import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rent_tech/display_all_products/allproducts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rent_tech/display_all_products/allproducts.dart';
import 'package:rent_tech/productScreens/accessoriesForRent.dart';
import 'package:rent_tech/productScreens/desktopsForRent.dart';
import 'package:rent_tech/productScreens/laptopsForRent.dart';

class ProductTypes extends StatefulWidget {
  @override
  _ProductTypes createState() => _ProductTypes();
}

class _ProductTypes extends State<ProductTypes> {
  int count = 0;
  countDocuments() async {//'is_available', isEqualTo: true
    QuerySnapshot myDoc2 =
        await FirebaseFirestore.instance.collection('Products')
        .where("is_available", isEqualTo: true).get();
    List<DocumentSnapshot> myDocCount2 = myDoc2.docs;
    //this.placeCount = myDocCount2.length;
    setState(() {
      count = myDocCount2.length;
    });
    print(count);

    // Count of Documents in Collection
  }

  @override
  void initState() {
    countDocuments();
    super.initState();
  }

  //final int documents = await FirebaseFirestore.instance.collection('products').snapshots().length;
  /* countDocuments() async {
   // FirebaseFirestore.instance.collection('product').snapshots().l
 //final String dc =  FirebaseFirestore.instance.collection('products').snapshots().length.toString();
//final QuerySnapshot qSnap = await Firestore.instance.collection('products').getDocuments();
//final int documents = qSnap.documents.lengt;
QuerySnapshot productCollection = await 
FirebaseFirestore.instance.collection('products').get();
int productCount = productCollection.size;
print(productCount);
  }
  */

  Widget build(BuildContext context) {
    //count;
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
                //String dc = FirebaseFirestore.instance.collection('products').snapshots().length.toString(),
                padding: EdgeInsets.fromLTRB(20, 1, 20, 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    //countDocuments(),
                    // FirebaseFirestore.instance.collection('products').snapshots().length;

                    ' ${this.count} items ',

                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                  ),
                ),
              ), // countDocuments(),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                height: 220,
                width: double.maxFinite,
                child: Card(
                  child: GestureDetector(
                   key:Key('laptop-pic'),
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
