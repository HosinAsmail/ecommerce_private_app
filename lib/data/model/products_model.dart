class ProductsModel {
  String? productsId;
  String? productsName;
  String? productsNameAr;
  String? productsDescription;
  String? productsDescriptionAr;
  String? productsImage;
  String? productsCount;
  String? productsActive;
  String? productsPrice;
  String? productsDiscount;
  String? productsDatetime;
  String? productsCategories;
  String? discountedPrice;

  ProductsModel(
      {this.productsId,
      this.discountedPrice,
      this.productsName,
      this.productsNameAr,
      this.productsDescription,
      this.productsDescriptionAr,
      this.productsImage,
      this.productsCount,
      this.productsActive,
      this.productsPrice,
      this.productsDiscount,
      this.productsDatetime,
      this.productsCategories});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    productsId = json['products_id'];
    productsName = json['products_name'];
    productsNameAr = json['products_name_ar'];
    discountedPrice = json['products_price_discount'];
    productsDescription = json['products_description'];
    productsDescriptionAr = json['products_description_ar'];
    productsImage = json['products_image'];
    productsCount = json['products_count'];
    productsActive = json['products_active'];
    productsPrice = json['products_price'];
    productsDiscount = json['products_discount'];
    productsDatetime = json['products_datetime'];
    productsCategories = json['products_categories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['products_id'] = productsId;
    data['products_name'] = productsName;
    data['products_name_ar'] = productsNameAr;
    data['products_description'] = productsDescription;
    data['products_description_ar'] = productsDescriptionAr;
    data['products_image'] = productsImage;
    data['products_count'] = productsCount;
    data['products_active'] = productsActive;
    data['products_price'] = productsPrice;
    data['products_discount'] = productsDiscount;
    data['products_datetime'] = productsDatetime;
    data['products_categories'] = productsCategories;
    data['products_price_discount'] = discountedPrice;
    return data;
  }
}
