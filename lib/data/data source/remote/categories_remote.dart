import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_private_app/core/api/crud.dart';
import 'package:ecommerce_private_app/core/api/status_request.dart';
import 'package:ecommerce_private_app/core/constant/app_links.dart';

class CategoriesRemote {
  Crud crud;
  CategoriesRemote(this.crud);
  getCategories() async {
    var response = await crud.getData(AppLinks.viewCategoriesLink);
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }

  deleteCategories(String categoriesId, String imageName) async {
    var response = await crud.postData(AppLinks.deleteCategoriesLink,
        {"categories_id": categoriesId, "image_name": imageName});
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }

  addCategories(String englishName, String arabicName, File file) async {
    var response = await crud.postRequestWithFile(AppLinks.addCategoriesLink,
        {"name": englishName, "name_ar": arabicName}, file);
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }

  editCategories(String categoriesId, String englishName, String arabicName,
      File? file, String? oldImage) async {
    Either<StatusFailureRequest, Map> response;
    if (file == null) {
      response = await crud.postData(AppLinks.editCategoriesLink, {
        "name": englishName,
        "name_ar": arabicName,
        "categories_id": categoriesId
      });
    } else {
      response = await crud.postRequestWithFile(
          AppLinks.editCategoriesLink,
          {
            "name": englishName,
            "name_ar": arabicName,
            "categories_id": categoriesId,
            "old_image": oldImage
          },
          file);
    }
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }
}
