import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class allAccessories extends StatefulWidget {
  @override
  _allAccessoriesState createState() => _allAccessoriesState();
}

class _allAccessoriesState extends State<allAccessories> {
  var documentID;

  Widget gridViewWidget(String img){
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
            onTap: (){},
            child: Center(
              child: Image.network(img, fit: BoxFit.fitHeight,),
            ),
          ),
          color: Colors.white,
        )
      ],

    );
  }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue[50],

        body:
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Products').where('Product_Type', isEqualTo: 'Accessory').snapshots(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              else if(snapshot.connectionState == ConnectionState.active){
                if(snapshot.data!.docs.isNotEmpty){
                  return GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2
                      ),
                      itemBuilder: (BuildContext context, int index){
                        return GestureDetector(

                          onTap: (){
                            documentID = snapshot.data!.docs[index].id;
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => BuyProduct(productID: documentID,)));
                          },
                          child: gridViewWidget(
                            snapshot.data!.docs[index]['Image'],

                          ),
                        );
                      });
                }
              }else{
                return Center(
                  child: Text('There is no Data to get'),
                );
              }
              return Center(
                child: Text('No Products in database!'),
              );
            }


        ),

      ),
    );
  }
}
