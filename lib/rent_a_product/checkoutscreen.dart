import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class checkout extends StatefulWidget {
  String? productID;

  checkout({Key? key, @required this.productID}) : super(key: key);

  @override
  _checkoutState createState() => _checkoutState();
}

class _checkoutState extends State<checkout> {
  @override  
  bool isAvailable2 = false;
  bool isCart2 = false;
  bool isCart = true;
  bool isAvailable = true;

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
                    //Text("$value"),
                  SizedBox(height:10),

                         Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection("Products")
                                      .doc(widget.productID)
                                      .update({
                                    'is_available': isAvailable2,
                                    'is_cart': isCart2,
                                  });
                                },
                                child: Text(
                                  "Rent $value",
                                  textAlign: TextAlign.left,
                                ))),
                            SizedBox(width: 20),
                        Expanded(
                            child: ElevatedButton(
                               style: ElevatedButton.styleFrom(
                                 primary: Colors.red,
                               ),
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection("Products")
                                      .doc(widget.productID)
                                      .update({
                                    'is_available': isAvailable,
                                    'is_cart': isCart2,
                                  });
                                },
                                child: Text(
                                  "Delete From Cart $value",
                                  textAlign: TextAlign.left,
                                )))
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
