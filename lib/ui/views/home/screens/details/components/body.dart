import 'package:ecomadmin/core/models/product_details_model.dart';
import 'package:ecomadmin/ui/views/home/models/product.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'chat_and_add_to_cart.dart';
import 'list_of_colors.dart';
import 'product_image.dart';

class Body extends StatelessWidget {
  final ProductDetailsModel product;

  const Body({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // it provide us total height and width
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small devices
    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios),
            ),
            expandedHeight: 256.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(product.productTitle),
              background: Center(
                child: Hero(
                  tag: '${product.productId}',
                  child: ProductPoster(
                    size: size,
                    image: product.imageUrl,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListOfColors(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: kDefaultPadding / 2),
                          child: Text(
                            product.productTitle,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Text(
                          '\$${product.price}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: kSecondaryColor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: kDefaultPadding / 2),
                          child: Text(
                            product.productDetail + product.productDetail,
                            style: TextStyle(color: kTextLightColor),
                          ),
                        ),
                        SizedBox(height: kDefaultPadding),
                      ],
                    ),
                  ),
                  ChatAndAddToCart(),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
