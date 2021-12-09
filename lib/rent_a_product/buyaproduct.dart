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
  //varaibles to chnage the database
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
        var price = document['Product_Price'];
        var condition = document['condition'];
        return Scaffold(
          body: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(3.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.all(Radius.circular(5.0), //                 <--- border radius here
                  ),),
                child: Image.network(imgurl),
              ),
              Container(
                margin: const EdgeInsets.all(5.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.all(Radius.circular(5.0), //                 <--- border radius here
        ),),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      //Use of SizedBox
                      height: 10,
                    ),

                    Container(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text("$value",
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,

                              ),),),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text("cost: $price /hr",
                              style: TextStyle(
                                fontSize: 22.0,
                              ),),),

                          Align(
                            alignment: Alignment.topLeft,
                            child: Text("condition $condition",
                              style: TextStyle(
                                fontSize: 22.0,

                              ),),),
                        ],
                      ),

                    ),

                    Row(
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
                                        // use the variables you initialize
                                        // us these varaibles to change the database 
                                        //after you click the button
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
