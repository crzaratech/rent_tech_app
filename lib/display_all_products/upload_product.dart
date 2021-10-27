import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_tech/authenticate/fire_auth.dart';
import 'dart:io';
import 'package:rent_tech/display_all_products/allproducts.dart';
import 'package:rent_tech/homescreen/home_screen.dart';

class uploadProduct extends StatefulWidget {
  @override
  _uploadProduct createState() => _uploadProduct();
}

enum pTypes { laptops, desktops }

class _uploadProduct extends State<uploadProduct> {
  //firebase
  final AuthService _auth = AuthService();
  //image data
  File? imageFile;
  String? imageUrl;

  //product data
  String? productCondition;
  bool isAvailable = true;
  late TextEditingController productName = TextEditingController(text: '');
  late TextEditingController price = TextEditingController(text: '');
  late TextEditingController zipCode = TextEditingController(text: '');
  pTypes? _productTypes;
  String? pId;
  String? pTypesValue;
  String? conditionValue;

//radio button list

  void _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    _cropImage(pickedFile!.path);
    //Navigator.pop(context);
  }

  void _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    //error on iphone
    _cropImage(pickedFile!.path);
    //Navigator.pop(context);
  }

  void _cropImage(filePath) async {
    File? croppedImage = await ImageCropper.cropImage(
      sourcePath: filePath,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    if (croppedImage != null) {
      setState(() {
        imageFile = croppedImage;
      });
    }
  }

  void _showImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Please choose an option'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    _getFromGallery();
                  },
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(Icons.photo, color: Colors.lightBlue),
                      ),
                      Text(
                        'Gallery',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _getFromCamera();
                  },
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(Icons.camera, color: Colors.lightBlue),
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
        });
  }

  void _upload_images() async {
    if (imageFile == null) {
      Fluttertoast.showToast(msg: "Please select an Image");
      return;
    }
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('userImages')
          .child(DateTime.now().toString() + 'jpg');
      await ref.putFile(imageFile!);
      imageUrl = await ref.getDownloadURL();
      FirebaseFirestore.instance.collection('Products').doc().set({
        'createdAt': DateTime.now(),
        'fromUserID': AuthService().getCurrentUser(),
        'email': AuthService().getCurrentUserEmail(),
        'Image': imageUrl,
        // 'product_Id' :
        'Product_Name': productName.text,
        'Product_Price': price.text,
        'is_available': isAvailable,
        'pType': pTypesValue,
      });
      //Navigator.canPop(context) ? Navigator.pop(context) : null;
      imageFile = null;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final _productfilldata = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Column(
        children: <Widget>[
          //add images container
          Container(
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.all(15.0),
            height: 180.0,
            width: double.infinity,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.lightBlueAccent,
            ),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                    radius: 40,
                    child: imageFile != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              imageFile!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fitHeight,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(50)),
                            width: 100,
                            height: 100,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey[800],
                            ),
                          )),
                ElevatedButton(
                    onPressed: () {
                      _showImageDialog();
                    },
                    child: Text("Add images")),
              ],
            ),
          ),
          Container(
            child: Center(
              child: Text("Product Details"),
            ),
          ),

          //Form Container that contains information about the product
          Container(
            padding: EdgeInsets.all(15.0),
            margin: EdgeInsets.all(10.0),
            child: Form(
              key: _productfilldata,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: productName,
                    decoration: const InputDecoration(
                      hintText: 'Enter the product name',
                    ),
                  ),
                  TextFormField(
                    controller: price,
                    decoration: const InputDecoration(
                      hintText: 'Price',
                    ),
                  ),
                  Row(children: <Widget>[
                    Flexible(
                        flex: 2,
                        child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text('Condition'))),
                    Flexible(
                        child: DropdownButton<String>(
                      value: conditionValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.blue),
                      underline: Container(
                        height: 2,
                        color: Colors.blue,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          conditionValue = newValue!;
                        });
                      },
                      items: <String>['Excellent', 'Moderate', 'Poor']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ))
                  ]),
                  Row(children: <Widget>[
                    Flexible(
                        flex: 2,
                        child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text('Type of device'))),
                    Flexible(
                        child: DropdownButton<String>(
                      value: pTypesValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.blue),
                      underline: Container(
                        height: 2,
                        color: Colors.blue,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          pTypesValue = newValue!;
                        });
                      },
                      items: <String>['Phone', 'Laptop', 'Desktop', 'Charger']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ))
                  ]),
                  TextFormField(
                    controller: zipCode,
                    decoration: const InputDecoration(
                      hintText: 'Zip Code',
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (imageFile != null) {
                          _upload_images();
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                      child: Text("Make Available to Rent!"))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
