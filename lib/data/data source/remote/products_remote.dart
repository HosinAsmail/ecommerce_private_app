import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_private_app/core/api/crud.dart';
import 'package:ecommerce_private_app/core/api/status_request.dart';
import 'package:ecommerce_private_app/core/constant/app_links.dart';

class ProductsRemote {
  Crud crud;
  ProductsRemote(this.crud);
  getProducts() async {
    var response = await crud.getData(AppLinks.viewProductsLink);
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }

  deleteProducts(String productsId, String imageName) async {
    var response = await crud.postData(AppLinks.deleteProductsLink,
        {"products_id": productsId, "image_name": imageName});
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }

  addProducts(
      String englishName,
      String arabicName,
      String englishDesc,
      String arabicDescAr,
      String count,
      String price,
      String discount,
      String active,
      String categoriesId,
      File file) async {
    var response = await crud.postRequestWithFile(
        AppLinks.addProductsLink,
        {
          "name": englishName,
          "name_ar": arabicName,
          "desc": englishDesc,
          "desc_ar": arabicDescAr,
          "count": count,
          "active": active,
          "price": price,
          "discount": discount,
          "categories_id": categoriesId
        },
        file);
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }

  editProducts(
      String productsId,
      String englishName,
      String arabicName,
      String englishDesc,
      String arabicDescAr,
      String count,
      String price,
      String discount,
      String active,
      String categoriesId,
      File? file,
      String? oldImage) async {
    Either<StatusFailureRequest, Map> response;
    if (file == null) {
      response = await crud.postData(AppLinks.editProductsLink, {
        "name": englishName,
        "name_ar": arabicName,
        "products_id": productsId,
        "desc": englishDesc,
        "desc_ar": arabicDescAr,
        "count": count,
        "active": active,
        "price": price,
        "discount": discount,
        "categories_id": categoriesId
      });
    } else {
      response = await crud.postRequestWithFile(
          AppLinks.editProductsLink,
          {
            "name": englishName,
            "name_ar": arabicName,
            "products_id": productsId,
            "desc": englishDesc,
            "desc_ar": arabicDescAr,
            "count": count,
            "active": active,
            "price": price,
            "discount": discount,
            "categories_id": categoriesId,
            "old_image": oldImage
          },
          file);
    }
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }
}
