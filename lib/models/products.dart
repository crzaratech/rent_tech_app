import 'package:cloud_firestore/cloud_firestore.dart';

class Products{
  late String id;
  late String pName;
  late String category;
  late String price;
  late String image;

  late List pDetails;
  late Timestamp createdAt;
   
      Products.fromMap(Map<String, dynamic> data){
        id = data['id'];
        id = data['pName'];
        id = data['category'];
        id = data['price'];
        id = data['image'];
        id = data['pDetails'];
        id = data['createdAt'];   
      }
}