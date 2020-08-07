import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCollection {
  static Future productDelete(String productId) async {
    return await Firestore.instance
        .collection('Products')
        .document(productId)
        .delete();
  }
}
