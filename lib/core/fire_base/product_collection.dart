import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomadmin/core/models/product_details_model.dart';

class ProductCollection {
  static Future productDelete(String productId) async {
    return await Firestore.instance
        .collection('Products')
        .document(productId)
        .delete();
  }

  static Future productUpload(ProductDetailsModel model) async {
    return await Firestore.instance
        .collection('Products')
        .document(model.productId.toString())
        .setData(model.toJson());
  }
}
