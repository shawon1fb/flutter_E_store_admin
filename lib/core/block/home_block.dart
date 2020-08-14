import 'dart:async';
import 'dart:core';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomadmin/core/block/base_block.dart';
import 'package:ecomadmin/core/constant/app_data.dart';
import 'package:ecomadmin/core/models/product_details_model.dart';
import 'package:ecomadmin/core/utils/log.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

class HomeBlock extends Object implements BaseBloc {
  @override
  void dispose() {
    // TODO: implement dispose
    allProductsStream?.close();
  }

  final allProductsStream = BehaviorSubject<String>();

  Function(String) get productQuery => allProductsStream.sink.add;

  Stream<List<ProductDetailsModel>> get getProductsListStream =>
      allProductsStream.stream.transform(_getProductList);

  var _getProductList =
      StreamTransformer<String, List<ProductDetailsModel>>.fromHandlers(
          handleData: (q, sink) async {
    var box = Hive.box('myBox');
    var data =
        await Firestore.instance.collection(AppData.products).getDocuments();
    L.log(data.documents.length, track: true);
    List<ProductDetailsModel> t = new List();
    data.documents.forEach((element) {
      ProductDetailsModel temp = ProductDetailsModel.fromJson(element.data);
      if (box.get('maxId') == null) {
        box.put('maxId', int.tryParse(temp.productId) ?? 0);
      } else {
        box.put(
          'maxId',
          max(int.tryParse(box.get('maxId').toString()) ?? 0,
              int.tryParse(temp.productId) ?? 0),
        );
      }
      t.add(temp);
    });

    if (q.length != 0)
      t = t
          .where((element) =>
              element.productTitle
                  .toString()
                  .toLowerCase()
                  .startsWith(q.toLowerCase()) ||
              element.productCategory.toString().toLowerCase() ==
                  q.toLowerCase())
          .toList();
    sink.add(t);
  });
}
