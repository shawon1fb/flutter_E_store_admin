import 'dart:io';
import 'package:ecomadmin/core/block/home_block.dart';
import 'package:ecomadmin/core/constant/product_category.dart';
import 'package:ecomadmin/core/fire_base/product_collection.dart';
import 'package:ecomadmin/core/models/product_details_model.dart';
import 'package:ecomadmin/core/utils/firebase_storage_method.dart';
import 'package:ecomadmin/core/utils/flutter_toast.dart';
import 'package:ecomadmin/core/utils/log.dart';
import 'package:ecomadmin/ui/animation/fade_animation_left.dart';
import 'package:ecomadmin/ui/animation/fade_animation_up.dart';
import 'package:ecomadmin/ui/dialog/dialog_router.dart';
import 'package:ecomadmin/ui/widgets/drop_down_list.dart';
import 'package:ecomadmin/ui/widgets/multi_line_text_field.dart';
import 'package:ecomadmin/ui/widgets/rounded_button.dart';
import 'package:ecomadmin/ui/widgets/text_inpute_WithPrefix_Suffix.dart';
import 'package:ecomadmin/ui/widgets/upload_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_responsive_screen/flutter_responsive_screen.dart';
import 'package:hive/hive.dart';

class NewProDuctUpload extends StatefulWidget {
  @override
  _NewProDuctUploadState createState() => _NewProDuctUploadState();
}

class _NewProDuctUploadState extends State<NewProDuctUpload> {
  final _formKey = GlobalKey<FormState>();
  File image;
  Color borderColor = Colors.white;
  HomeBlock homeBlock = new HomeBlock();
  String productName;
  String productId;
  String productCategory;
  String productPrice;
  String productDetails;

  TextEditingController productNameController = new TextEditingController();
  TextEditingController productIdController = new TextEditingController();
  TextEditingController productPriceController = new TextEditingController();
  TextEditingController productDetailsController = new TextEditingController();

  FocusNode nameNode = FocusNode();
  FocusNode idNode = FocusNode();
  FocusNode categoryNode = FocusNode();
  FocusNode priceNode = FocusNode();
  FocusNode detailsNode = FocusNode();

  @override
  void dispose() {
    nameNode.dispose();
    idNode.dispose();
    categoryNode.dispose();
    priceNode.dispose();
    detailsNode.dispose();
    super.dispose();
  }

  uploadProducts() async {
    productName = productNameController.text;
    productId = productIdController.text;
    productPrice = productPriceController.text;
    productDetails = productDetailsController.text;
    if (image == null) {
      borderColor = Colors.red;
      setState(() {});
      FlutterToast.showErrorToast(
          context: context, message: "Please select a product Image");
      return;
    }
    if (_formKey.currentState.validate()) {
      DialogRouter.displayProgressDialog(context);
      String url = await FlutterFireBaseStorage.uploadImage(
          imageFile: image, dirName: 'products');
      if (url == null) {
        DialogRouter.closeProgressDialog(context);
        FlutterToast.showErrorToast(
            context: context, message: "image upload failed");
        return;
      }

      productId = (box.get('maxId') + 1).toString();
      box.put('maxId', box.get('maxId') + 1);
      ProductDetailsModel productModel = new ProductDetailsModel(
        imageUrl: url,
        price: productPrice,
        productCategory: productCategory,
        productDetail: productDetails,
        productId: productId,
        productTitle: productName,
      );
      L.map(productModel.toJson());

      ProductCollection.productUpload(productModel).then((value) {
        clearAllData();
        DialogRouter.closeProgressDialog(context);
        FlutterToast.showSuccess(context: context, message: 'Product uploaded');
      });
    }
  }

  clearAllData() {
    image = null;
    productNameController.clear();
    productIdController.clear();
    productPriceController.clear();
    productDetailsController.clear();
    setState(() {});
  }

  allUnFocus() {
    nameNode.unfocus();
    idNode.unfocus();
    categoryNode.unfocus();
    priceNode.unfocus();
    detailsNode.unfocus();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeBlock.productQuery('');
    productCategory =
        ProductCategory.categoryToId[ProductCategory.categoryList.first];
    // box.put('name', 'Shawon');
  }

  var box = Hive.box('myBox');

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(MediaQuery.of(context).size).wp;
    final Function hp = Screen(MediaQuery.of(context).size).hp;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF035AA6),
        title: Text(
          //'${box.get('maxId')}',
            'Add Product',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                    width: wp(100),
                  ),
                  FadeAnimationLeft(
                    child: UploadImageCard(
                      borderColor: borderColor,
                      image: image,
                      onImageSelect: (file) {
                        image = file;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        FadeAnimationUp(
                          delay: 0.5,
                          child: TextInputWithPrefixSuffix(
                            hint: 'Product Name',
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            controller: productNameController,
                            focusNode: nameNode,
                            onFieldSubmitted: (v) {
                              nameNode.unfocus();
                              idNode.requestFocus();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        /*      FadeAnimationUp(
                          delay: 0.7,
                          child: TextInputWithPrefixSuffix(
                            hint: 'Product Id',
                            controller: productIdController,
                            inputType: TextInputType.number,
                            focusNode: idNode,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter Id';
                              }
                              return null;
                            },
                            onFieldSubmitted: (v) {
                              idNode.unfocus();
                              priceNode.requestFocus();
                            },
                          ),
                        ),*/
                        /* SizedBox(
                          height: 15,
                        ),*/
                        FadeAnimationUp(
                          delay: 0.9,
                          child: TextInputWithPrefixSuffix(
                            hint: 'Product Price',
                            inputType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter price';
                              }
                              return null;
                            },
                            controller: productPriceController,
                            focusNode: priceNode,
                            onFieldSubmitted: (v) {
                              priceNode.unfocus();
                              categoryNode.requestFocus();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FadeAnimationUp(
                          delay: 1.1,
                          child: DropDownList(
                            dropdownNode: categoryNode,
                            itemList: ProductCategory.categoryList,
                            hint: ProductCategory.categoryList.first,
                            onChanged: (v) {
                              categoryNode.unfocus();
                              detailsNode.requestFocus();
                              productCategory = ProductCategory.categoryToId[v];
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FadeAnimationUp(
                          delay: 1.3,
                          child: MultiLineTextField(
                            hint: "product Details",
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter product details';
                              }
                              return null;
                            },
                            controller: productDetailsController,
                            focusNode: detailsNode,
                            onFieldSubmitted: (v) {
                              detailsNode.unfocus();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  FadeAnimationUp(
                    delay: 1.5,
                    child: RoundBoarderButton(
                      text: 'Upload',
                      onPress: () {
                        allUnFocus();
                        uploadProducts();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
