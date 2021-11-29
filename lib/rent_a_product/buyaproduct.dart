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
  bool isCart = true;
  bool isAvailable = false;
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection("Products")
          .doc(widget.productID)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new CircularProgressIndicator();
        }
        var document = snapshot.data!.data();
        var value = document!['Product_Name'];
        var imgurl = document['Image'];
        return Scaffold(
          body: Column(
            children: <Widget>[
              Container(
                child: Image.network(imgurl),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      //Use of SizedBox
                      height: 10,
                    ),
                    /* ElevatedButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("Products")
                              .doc(widget.productID)
                              .update({
                            'is_available': isAvailable,
                          });
                        },
                        child: Text("Rent $value")),*/
                    Row(
                       //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 20),
                        Expanded(
                           child: Padding(
                             padding: EdgeInsets.fromLTRB(10.0, 10.0, 30.0, 10.0),
                                child: ElevatedButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection("Products")
                                          .doc(widget.productID)
                                          .update({
                                        'is_available': isAvailable,
                                        'is_cart': isCart,
                                      });
                                    },
                                    child: Text(
                                      "Add To Cart $value",
                                      textAlign: TextAlign.left,
                                    ))))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    ));
  }
}
