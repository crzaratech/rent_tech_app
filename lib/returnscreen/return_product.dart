import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReturnProduct extends StatefulWidget {
  String? productID;

  ReturnProduct({Key? key, @required this.productID}) : super(key: key);

  @override
  _ReturnProductState createState() => _ReturnProductState();
}

class _ReturnProductState extends State<ReturnProduct> {
  @override
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
                                    'is_available': isAvailable,
                                  });
                                },
                                child: Text(
                                  "Return $value",
                                  textAlign: TextAlign.left,
                                ))),
                            SizedBox(width: 20),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection("Products")
                                      .doc(widget.productID)
                                      .update({
                                    'is_available': isAvailable,
                                  });
                                },
                                child: Text(
                                  "Extend $value",
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
