import 'package:bloc/bloc.dart';
import 'package:ecommerce_private_app/core/functions/check_internet_function.dart';
import 'package:ecommerce_private_app/data/data%20source/remote/ads_remote.dart';
import 'package:ecommerce_private_app/data/model/ads_model.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

import '../../core/api/crud.dart';
import '../../core/functions/handling_failure_response.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  AdsCubit() : super(AdsInitial());
  Crud crud = Crud();
  List<AdsModel> ads = [];
  void addAds(String englishTitle, String arabicTitle, String englishBody,
      String arabicBody, String color, String colorCircle) async {
    emit(AddAdsLoading());
    if (await checkInternetFunction()) {
      try {
        AdsRemote adsRemote = AdsRemote(crud);
        var response = await adsRemote.addAds(englishTitle, arabicTitle,
            englishBody, arabicBody, color, colorCircle);
        if (response is Map<String, dynamic>) {
          ads.add(AdsModel.fromJson(response['data'][0]));
        }
        String? failureMessage = handlingFailureMessage(
            response, "اسم الصورة موجوج مسبقا الرجاء تغيير اسم الصورة");
        if (failureMessage != null) {
          emit(AddAdsFailure(errorMessage: failureMessage));
        } else {
          emit(AddAdsSuccess());
        }
      } on Exception catch (e) {
        if (e is ClientException) {
          emit(const AddAdsFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(AddAdsFailure(errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      emit(const AddAdsFailure(
          errorMessage:
              "your offline, please turn on the internet and try again"));
    }
  }

  void editAds(
      String adsId,
      String englishTitle,
      String arabicTitle,
      String englishBody,
      String arabicBody,
      String color,
      String colorCircle) async {
    emit(EditAdsLoading());
    if (await checkInternetFunction()) {
      try {
        AdsRemote adsRemote = AdsRemote(crud);
        var response = await adsRemote.editAds(adsId, englishTitle, arabicTitle,
            englishBody, arabicBody, color, colorCircle);

        String? failureMessage = handlingFailureMessage(
            response, "اسم الصورة موجوج مسبقا الرجاء تغيير اسم الصورة");
        if (failureMessage != null) {
          emit(EditAdsFailure(errorMessage: failureMessage));
        } else {
          int index = ads.indexWhere((element) => element.adsId == adsId);
          ads[index].adsTitle = englishTitle;
          ads[index].adsTitleAr = arabicTitle;
          ads[index].adsBody = englishBody;
          ads[index].adsBodyAr = arabicBody;
          ads[index].adsColor = color;
          ads[index].adsColorCircle = colorCircle;
          emit(EditAdsSuccess());
        }
      } on Exception catch (e) {
        if (e is ClientException) {
          emit(const EditAdsFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(
            EditAdsFailure(errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      emit(const EditAdsFailure(
          errorMessage:
              "your offline, please turn on the internet and try again"));
    }
  }

  Future<void> deleteAds(String adsId) async {
    emit(DeleteAdsLoading());
    if (await checkInternetFunction()) {
      try {
        AdsRemote adsRemote = AdsRemote(crud);
        var response = await adsRemote.deleteAds(adsId);

        String? failureMessage = handlingFailureMessage(response, "no data");
        if (failureMessage != null) {
          emit(DeleteAdsFailure(errorMessage: failureMessage));
        } else {
          ads.removeWhere((element) => element.adsId == adsId);
          emit(DeleteAdsSuccess());
        }
      } on Exception catch (e) {
        if (e is ClientException) {
          emit(const DeleteAdsFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(DeleteAdsFailure(
            errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      emit(const DeleteAdsFailure(
          errorMessage:
              "your offline, please turn on the internet and try again"));
    }
  }

  void getAds() async {
    emit(GetAdsLoading());
    if (ads.isEmpty) {
      getAsyncAds();
    } else {
      emit(GetAdsSuccess());
    }
  }

  void getAsyncAds() async {
    emit(GetAdsLoading());
    if (await checkInternetFunction()) {
      try {
        AdsRemote adsRemote = AdsRemote(crud);
        var response = await adsRemote.getAds();
        if (response is Map<String, dynamic>) {
          ads.clear();
          for (final ad in response['data']) {
            ads.add(AdsModel.fromJson(ad));
          }
        }
        String? failureMessage = handlingFailureMessage(response, "no data");
        if (failureMessage != null) {
          print(failureMessage);
          emit(GetAdsFailure(errorMessage: failureMessage));
        } else {
          emit(GetAdsSuccess());
        }
      } on Exception catch (e) {
        print(e);
        if (e is ClientException) {
          emit(const GetAdsFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(GetAdsFailure(errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      print("problem in internet");
      emit(const GetAdsFailure(
          errorMessage:
              "your offline, please turn on the internet and try again"));
    }
  }
}
