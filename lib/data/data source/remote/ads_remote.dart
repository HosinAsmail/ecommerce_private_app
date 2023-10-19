import 'package:dartz/dartz.dart';
import 'package:ecommerce_private_app/core/api/crud.dart';
import 'package:ecommerce_private_app/core/api/status_request.dart';
import 'package:ecommerce_private_app/core/constant/app_links.dart';

class AdsRemote {
  Crud crud;
  AdsRemote(this.crud);
  getAds() async {
    var response = await crud.getData(AppLinks.viewAdsLink);
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }

  deleteAds(String adsId) async {
    var response =
        await crud.postData(AppLinks.deleteAdsLink, {"ads_id": adsId});
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }

  addAds(String englishTitle, String arabicTitle, String englishBody,
      String arabicBody, String color, String colorCircle) async {
    var response = await crud.postData(
      AppLinks.addAdsLink,
      {
        "title": englishTitle,
        "title_ar": arabicTitle,
        "body": englishBody,
        "body_ar": arabicBody,
        "color": color,
        "color_circle": colorCircle
      },
    );
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }

  editAds(
      String adsId,
      String englishTitle,
      String arabicTitle,
      String englishBody,
      String arabicBody,
      String color,
      String colorCircle) async {
    Either<StatusFailureRequest, Map> response;
    response = await crud.postData(AppLinks.editAdsLink, {
      "title": englishTitle,
      "title_ar": arabicTitle,
      "body": englishBody,
      "body_ar": arabicBody,
      "color": color,
      "color_circle": colorCircle,
      "ads_id": adsId
    });
    var resp = response.fold((l) => l, (r) => r);
    return resp;
  }
}
