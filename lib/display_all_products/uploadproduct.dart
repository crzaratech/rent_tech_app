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

import 'package:flutter/services.dart';

class uploadProduct extends StatefulWidget {
  @override
  _uploadProduct createState() => _uploadProduct();
}

enum pTypes { laptops, desktops, accessories }

class _uploadProduct extends State<uploadProduct> {
  //firebase
  final AuthService _auth = AuthService();
  //image data
  File? imageFile;
  String? imageUrl;

  //product data
  String? productCondition;
  bool isAvailable = true;
  bool isCart = false;
  late TextEditingController productName = TextEditingController(text: '');
  late TextEditingController price = TextEditingController(text: '');
  late TextEditingController zipCode = TextEditingController(text: '');
  pTypes? _productTypes;
  String? pId;
  String? pTypesValue;
  String? conditionValue;
  final List<String> product_types = ['Phone', 'Laptop', 'Desktop', 'Charger'];
  final List<String> product_condition = ['Excellent', 'Moderate', 'Poor'];
  final List<String> product_time_types = ['hour', 'day', 'week'];
  String? pTypesTime;
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
        'Product_Type': pTypesValue,
        'Product_Time_Type': pTypesTime,
        'is_available': isAvailable,
        'condition': conditionValue,
        'zip_code': zipCode.text,
        'is_cart': isCart,
      });
      //Navigator.canPop(context) ? Navigator.pop(context) : null;
      imageFile = null;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  final _productfilldata = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[50],
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showImageDialog();
          },
          child: const Icon(Icons.camera_alt),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //Form Container that contains information about the product
              Container(
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.all(10.0),
                child: Form(
                  key: _productfilldata,
                  child: Column(
                    children: <Widget>[
                      Container(
                          child: SizedBox(
                              height: 200,
                              child: imageFile != null
                                  ? Card(
                                      child: Image.file(
                                        imageFile!,
                                        width: 400,
                                        height: 200,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    )
                                  : const Card(
                                      elevation: 5,
                                      child: Center(
                                        child:
                                            Text("No image has been uploaded"),
                                      ),
                                    ))),
                      const SizedBox(height: 15),
                      //product name
                      TextFormField(
                        controller: productName,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter the product name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a valid product name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      //price
                      TextFormField(
                        controller: price,
                        maxLength: 6,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Price',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a price for the product';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Enter a valid price';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      //type of timeframe(hour,etc)
                      Row(children: <Widget>[
                        const Flexible(
                            flex: 2,
                            child: Padding(
                                padding: EdgeInsets.only(right: 150.0),
                                child: Text('Time-Rate Charged'))),
                        Flexible(
                            child: DropdownButtonFormField<String>(
                          value: pTypesTime,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.blue),
                          onChanged: (String? newValue) {
                            setState(() {
                              pTypesTime = newValue!;
                            });
                          },
                          items: product_time_types.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          validator: (value) =>
                              value == null ? ' Add valid time-rate.' : null,
                        ))
                      ]),
                      const SizedBox(height: 20.0),
                      //dropdown condition #add condition of device
                      Row(children: <Widget>[
                        const Flexible(
                            flex: 2,
                            child: Padding(
                                padding: EdgeInsets.only(right: 165.0),
                                child: Text('Product Condition'))),
                        Flexible(
                            child: DropdownButtonFormField<String>(
                          value: conditionValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.blue),
                          onChanged: (String? newValue) {
                            setState(() {
                              conditionValue = newValue!;
                            });
                          },
                          items: product_condition.map((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          validator: (value) =>
                              value == null ? 'Add valid condition.' : null,
                        ))
                      ]),
                      const SizedBox(height: 20.0),
                      //dropdown type of product
                      Row(children: <Widget>[
                        const Flexible(
                            flex: 2,
                            child: Padding(
                                padding: EdgeInsets.only(right: 145.0),
                                child: Text('Product Type'))),
                        Flexible(
                            child: DropdownButtonFormField<String>(
                          value: pTypesValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.blue),
                          onChanged: (String? newValue) {
                            setState(() {
                              pTypesValue = newValue!;
                            });
                          },
                          items: product_types.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          validator: (value) =>
                              value == null ? 'Add valid product type.' : null,
                        ))
                      ]),
                      const SizedBox(height: 20.0),
                      //zip code
                      TextFormField(
                        controller: zipCode,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp("[.]")),
                          FilteringTextInputFormatter.deny(RegExp("[,]"))
                        ],
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: false,
                        ),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Zip Code',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a zip code';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      //Submit product bttn
                      ElevatedButton(
                          onPressed: () async {
                            if (_productfilldata.currentState!.validate() &&
                                imageFile != null) {
                              _upload_images();
                              //displays to user that product has been uploaded to firebase
                              showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                          title: const Text('Product Upload'),
                                          content: const Text(
                                              'Product has been uploaded.'),
                                          actions: <Widget>[
                                            TextButton(
                                                onPressed: () => {
                                                      Navigator.pop(
                                                          context, 'OK')
                                                    },
                                                child: const Text('Ok'))
                                          ]));
                            } else {
                              showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                          title: const Text(
                                              'Product does not contain images/fields'),
                                          content: const Text(
                                              'Please include missing fields.'),
                                          actions: <Widget>[
                                            TextButton(
                                                onPressed: () => {
                                                      Navigator.pop(
                                                          context, 'OK')
                                                    },
                                                child: const Text('Ok'))
                                          ]));
                            }
                          },
                          child: const Text("Upload Product"))
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
