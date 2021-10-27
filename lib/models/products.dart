import 'package:cloud_firestore/cloud_firestore.dart';

class Products{
  late String? pid;
  late String pName;
  late String category;
  late String price;
  late String image;

  late List pDetails;
  late Timestamp createdAt;

  Products({this.pid});
      Products.fromMap(Map<String, dynamic> data){
        pid = data['id'];
        pName = data['pName'];
        category = data['category'];
        price = data['price'];
        image = data['image'];
        pDetails = data['pDetails'];
        createdAt = data['createdAt'];
      }

      Future<String> getDataFS(DocumentReference doc_ref) async{
        DocumentSnapshot docSnaphot = await doc_ref.get();
        var tempdocid = docSnaphot.reference.id;
        return tempdocid;
      }
}