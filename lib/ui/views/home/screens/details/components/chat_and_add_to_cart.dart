import 'package:ecomadmin/core/fire_base/product_collection.dart';
import 'package:ecomadmin/core/models/product_details_model.dart';
import 'package:ecomadmin/core/utils/flutter_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class ChatAndAddToCart extends StatelessWidget {
  const ChatAndAddToCart({
    Key key,
    this.product,
  }) : super(key: key);

  final ProductDetailsModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kDefaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFFCBF1E),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: <Widget>[
          SvgPicture.asset(
            "assets/icons/chat.svg",
            height: 18,
          ),
          SizedBox(width: kDefaultPadding / 2),
          Text(
            "update",
            style: TextStyle(color: Colors.white),
          ),
          // it will cover all available spaces
          Spacer(),
          FlatButton.icon(
            onPressed: () {
              ProductCollection.productDelete(product.productId.toString())
                  .then((value) {
                FlutterToast.showSuccess(
                    context: context, message: 'product deleted');
                Navigator.pop(context);
              });
            },
            icon: SvgPicture.asset(
              "assets/icons/shopping-bag.svg",
              height: 18,
            ),
            label: Text(
              "Delete",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
