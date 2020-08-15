import 'package:ecomadmin/core/fire_base/product_collection.dart';
import 'package:ecomadmin/core/models/product_details_model.dart';
import 'package:ecomadmin/core/utils/flutter_toast.dart';
import 'package:ecomadmin/ui/views/update_product/update_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

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
          Icon(
            FontAwesomeIcons.penSquare,
            size: 18,
            color: Colors.white,
          ),
          SizedBox(width: kDefaultPadding / 2),
          InkWell(
            onTap: () async {
              await Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.scale,
                  alignment: Alignment.bottomCenter,
                  child: UpdateProductPage(
                    model: product,
                  ),
                ),
              );
              Navigator.pop(context);
            },
            child: Text(
              "Update",
              style: TextStyle(color: Colors.white),
            ),
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
            icon: Icon(
              Icons.delete,
              color: Colors.white,
              size: 18,
            ),
            label: Center(
              child: Text(
                "Delete",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
