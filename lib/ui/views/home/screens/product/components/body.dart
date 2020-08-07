import 'package:ecomadmin/core/block/home_block.dart';
import 'package:ecomadmin/core/fire_base/product_collection.dart';
import 'package:ecomadmin/core/models/product_details_model.dart';
import 'package:ecomadmin/core/utils/flutter_toast.dart';
import 'package:ecomadmin/core/utils/log.dart';
import 'package:ecomadmin/ui/animation/fade_animation.dart';
import 'package:ecomadmin/ui/views/home/components/search_box.dart';
import 'package:ecomadmin/ui/views/home/models/product.dart';
import 'package:ecomadmin/ui/views/home/screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'category_list.dart';
import 'product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  HomeBlock homeBlock = new HomeBlock();
  int category = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getProductsFromFireStore();
    homeBlock.productQuery('');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: <Widget>[
          SearchBox(onChanged: (value) {
            homeBlock.productQuery(value);
          }),
          CategoryList(
            onSelect: (index) {
              if (index == 0) return homeBlock.productQuery('');
              category = index;
              homeBlock.productQuery(index.toString());
            },
          ),
          SizedBox(height: kDefaultPadding / 2),
          Expanded(
            child: Stack(
              children: <Widget>[
                // Our background
                Container(
                  margin: EdgeInsets.only(top: 70),
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
                StreamBuilder<List<ProductDetailsModel>>(
                    stream: homeBlock.getProductsListStream,
                    builder: (BuildContext context, snapshot) {
                      if (!snapshot.hasData) {
                        // appState.getProductsFromFireStore();
                        return Center(child: new Text('loading...'));
                      }
                      return ListView.builder(
                        // here we use our demo procuts list
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) => FadeAnimation(
                            0.8,
                            ProductCard(
                              itemIndex: i,
                              product: snapshot.data[i],
                              press: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                      product: snapshot.data[i],
                                    ),
                                  ),
                                );
                                if (category != 0)
                                  homeBlock.productQuery(category.toString());
                                else
                                  homeBlock.productQuery('');
                              },
                              onDelete: () {
                                print('onDelete clicked');
                                ProductCollection.productDelete(
                                        snapshot.data[i].productId.toString())
                                    .then((value) {
                                  snapshot.data.removeAt(i);
                                  if (category != 0)
                                    homeBlock.productQuery(category.toString());
                                  else
                                    homeBlock.productQuery('');
                                  FlutterToast.showSuccess(
                                      context: context,
                                      message: "product Deleted");
                                });
                              },
                            )),
                      );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
