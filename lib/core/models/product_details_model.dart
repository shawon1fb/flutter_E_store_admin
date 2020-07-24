class ProductDetailsModel {
  final productTitle;
  final price;
  final productDetail;
  final productId;
  final imageUrl;
  final productCategory;

  Map<String, dynamic> toJson() => {
        'productTitle': productTitle,
        'price': price,
        'productDetail': productDetail,
        'productId': productId,
        'ImageUrl': imageUrl,
        'productCategory': productCategory,
      };

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      imageUrl: json['ImageUrl'],
      productCategory: json['productCategory'],
      price: json['price'],
      productId: json['productId'],
      productDetail: json["productDetail"],
      productTitle: json["productTitle"],
    );
  }

  ProductDetailsModel({
    this.productTitle,
    this.price,
    this.productDetail,
    this.productId,
    this.productCategory,
    this.imageUrl,
  });
}
