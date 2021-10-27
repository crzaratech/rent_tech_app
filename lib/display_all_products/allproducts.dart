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


class AllProducts extends StatefulWidget {
  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final AuthService _auth = AuthService();
  final Products _fsmanage = Products();
  File? imageFile;
  String? imageUrl;
  var documentID;
 
  void _getFromGallery() async{
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 1080,
      maxWidth: 1080,

    );
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromCamera() async{
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 1080,
      maxWidth: 1080,

    );
    //error on iphone
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _cropImage(filePath) async{
    File? croppedImage = await ImageCropper.cropImage(
      sourcePath: filePath,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    if(croppedImage != null){
      setState((){
        imageFile = croppedImage;
      });
    }
  }

  void _showImageDialog(){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Please choose an option'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: (){
                    _getFromGallery();
                  },
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                            Icons.photo,
                            color: Colors.lightBlue
                        ),
                      ),
                      Text(
                        'Gallery',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    _getFromCamera();
                  },
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                            Icons.camera,
                            color: Colors.lightBlue
                        ),
                      ),
                      Text(
                        'Camera',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

    );
  }

  void _upload_images() async{
    if(imageFile == null){
      Fluttertoast.showToast(msg: "Please select an Image");
      return;
    }
    try{
      final ref = FirebaseStorage.instance.ref().child('userImages').child(DateTime.now().toString()+'jpg');
      await ref.putFile(imageFile!);
      imageUrl = await ref.getDownloadURL();
      FirebaseFirestore.instance.collection('Products').doc(DateTime.now().toString()).set({
        'id': AuthService().getCurrentUser(),
        'email': AuthService().getCurrentUserEmail(),
        'Image': imageUrl,
        'createdAt': DateTime.now(),
      });
      //Navigator.canPop(context) ? Navigator.pop(context) : null;
      imageFile = null;
    }
    catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue[50],

        body:
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('Products').orderBy("createdAt",descending: true).snapshots(),
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
                                Navigator.push(context, MaterialPageRoute(builder: (context) => BuyProduct(productID: documentID,)));
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


