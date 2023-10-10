import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot>> getPhones() async {
    QuerySnapshot querySnapshot = await db.collection("phones").get();
    return querySnapshot.docs;
  }
}
