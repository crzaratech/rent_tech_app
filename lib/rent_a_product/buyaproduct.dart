import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class BuyProduct extends StatefulWidget {
  String? productID;

  BuyProduct({Key? key, @required this.productID}) : super(key: key);

  @override
  _BuyProductState createState() => _BuyProductState();
}

class _BuyProductState extends State<BuyProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: StreamBuilder(
      //   stream: FirebaseFirestore.instance.collection("Products"),
      //
      //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  },
      // )
    );
  }
}
