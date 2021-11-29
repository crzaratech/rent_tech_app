import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rent_tech/models/products.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_tech/authenticate/fire_auth.dart';
import 'package:rent_tech/rent_a_product/buyaproduct.dart';
import 'package:rent_tech/rent_a_product/checkoutscreen.dart';
import 'package:rent_tech/returnscreen/return_product.dart';

class shoppingcart extends StatefulWidget {
  @override
  _shoppingcart createState() => _shoppingcart();
}

class _shoppingcart extends State<shoppingcart> {
  var documentID;

  int count = 0;
  countDocuments() async {
    //'is_available', isEqualTo: true
    QuerySnapshot myDoc2 = await FirebaseFirestore.instance
        .collection('Products')
        .where("is_cart", isEqualTo: true)
        .get();
    List<DocumentSnapshot> myDocCount2 = myDoc2.docs;
    //this.placeCount = myDocCount2.length;
    setState(() {
      count = myDocCount2.length;
    });
    print(count);
  }

  @override
  void initState() {
    countDocuments();
    super.initState();
  }

  Widget gridViewWidget(String img,String name, String price){

    return GridView.count(
      primary: false,
      padding: EdgeInsets.all(5),
      crossAxisCount: 1,
      crossAxisSpacing: 1,
      children: [
        Container(
          
          alignment: Alignment.center,
          padding: EdgeInsets.all(0),
          child: GestureDetector(
            onTap: () {},
            child: IgnorePointer(
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    image: DecorationImage(
                      image: NetworkImage(img),
                      fit: BoxFit.cover,
                    ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black,
                          Color(0x19000000),
                        ],
                          begin: FractionalOffset(0.0, 1.0),
                          end: FractionalOffset(0.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                      ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            name,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,color: Colors.white),
                          ),
                          Text(
                            '\$${price}/hr',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    ),
                  ),
                ),
              ),
            ),
            ),
          ),
        ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: new AppBar(
      
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: new Text('${this.count} items ',
        
          
          
          style: TextStyle(
            fontSize: 30,
             color: Colors.black,),
          
          ),
        ),
        //backgroundColor: Colors.blue[50],
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Products')
                .where('is_cart', isEqualTo: true)
                .snapshots(),
                // how to display all the items in the cart
              
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.data!.docs.isNotEmpty) {
                  return GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                           onTap: (){
                            documentID = snapshot.data!.docs[index].id;
                            Navigator.push(context, MaterialPageRoute(builder: (context) => checkout(productID: documentID,)));
                          },
                          child: gridViewWidget(
                            snapshot.data!.docs[index]['Image'],
                            snapshot.data!.docs[index]['Product_Name'],
                            snapshot.data!.docs[index]['Product_Price'],
                          ),
                        );
                      });
                }
              } else {
                return Center(
                  child: Text('There is no Data to get'),
                );
              }
              return Center(
                child: Text('No Products in database!'),
              );
            }),
      ),
    );
  }
}
