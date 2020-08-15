import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
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
import 'package:path_provider/path_provider.dart';

class UpdateProductPage extends StatefulWidget {
  final ProductDetailsModel model;

  UpdateProductPage({
    this.model,
  });

  @override
  _UpdateProductPageState createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  final _formKey = GlobalKey<FormState>();
  File image;
  File updatedImage;
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
      String productUrl = widget.model.imageUrl;
      DialogRouter.displayProgressDialog(context);
      if (updatedImage != null) {
        String url = await FlutterFireBaseStorage.uploadImage(
            imageFile: updatedImage, dirName: 'products');
        if (url == null) {
          DialogRouter.closeProgressDialog(context);
          FlutterToast.showErrorToast(
              context: context, message: "image upload failed");
          return;
        } else {
          productUrl = url;
        }
      }

      productId = widget.model.productId.toString();

      ProductDetailsModel productModel = new ProductDetailsModel(
        imageUrl: productUrl,
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
        FlutterToast.showSuccess(context: context, message: 'Product updated');
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

    initialValue();
  }

  initialValue() async {
    productCategory = widget.model.productCategory.toString();
    productNameController.text = widget.model.productTitle;
    productPriceController.text = widget.model.price.toString();
    productDetailsController.text = widget.model.productDetail;
    image = await urlToFile(widget.model.imageUrl);
    setState(() {});
  }

  Future<File> urlToFile(String imageUrl) async {
// generate random number.
    var rng = new Random();
// get temporary directory of device.
    Directory tempDir = await getTemporaryDirectory();
// get temporary path from temporary directory.
    String tempPath = tempDir.path;
// create a new file in temporary path with random file name.
    File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
// call http.get method and pass imageUrl into it to get response.
    http.Response response = await http.get(imageUrl);
// write bodyBytes received in response to file.
    await file.writeAsBytes(response.bodyBytes);
// now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.
    return file;
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
          'Update Product',
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
                        updatedImage = image;
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
                            hint: ProductCategory
                                .idToCategory[widget.model.productCategory],
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
                      text: 'UPDATE',
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
