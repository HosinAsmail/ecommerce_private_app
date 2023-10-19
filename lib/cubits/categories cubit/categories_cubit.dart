import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_private_app/core/functions/check_internet_function.dart';
import 'package:ecommerce_private_app/core/functions/pick_file.dart';
import 'package:ecommerce_private_app/data/data%20source/remote/categories_remote.dart';
import 'package:ecommerce_private_app/data/model/categories_model.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

import '../../core/api/crud.dart';
import '../../core/functions/handling_failure_response.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());
  Crud crud = Crud();
  List<CategoriesModel> categories = [];
  File? imageFile;
  void addCategories(String englishName, String arabicName) async {
    emit(AddCategoriesLoading());
    if (await checkInternetFunction()) {
      try {
        CategoriesRemote categoriesRemote = CategoriesRemote(crud);
        var response = await categoriesRemote.addCategories(
            englishName, arabicName, imageFile!);
        if (response is Map<String, dynamic>) {
          categories.add(CategoriesModel.fromJson(response['data'][0]));
        }
        String? failureMessage = handlingFailureMessage(
            response, "اسم الصورة موجوج مسبقا الرجاء تغيير اسم الصورة");
        if (failureMessage != null) {
          emit(AddCategoriesFailure(errorMessage: failureMessage));
        } else {
          emit(AddCategoriesSuccess());
          imageFile = null;
        }
      } on Exception catch (e) {
        if (e is ClientException) {
          emit(const AddCategoriesFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(AddCategoriesFailure(
            errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      emit(const AddCategoriesFailure(
          errorMessage:
              "your offline, please turn on the internet and try again"));
    }
  }

  void editCategories(String categoriesId, String englishName,
      String arabicName, String oldImage) async {
    emit(EditCategoriesLoading());
    if (await checkInternetFunction()) {
      try {
        CategoriesRemote categoriesRemote = CategoriesRemote(crud);
        var response = await categoriesRemote.editCategories(
            categoriesId, englishName, arabicName, imageFile, oldImage);

        String? failureMessage = handlingFailureMessage(
            response, "اسم الصورة موجوج مسبقا الرجاء تغيير اسم الصورة");
        if (failureMessage != null) {
          emit(EditCategoriesFailure(errorMessage: failureMessage));
        } else {
          int index = categories
              .indexWhere((element) => element.categoriesId == categoriesId);
          categories[index].categoriesName = englishName;
          categories[index].categoriesNameAr = arabicName;
          if (imageFile != null) {
            categories[index].categoriesImage =
                imageFile!.path.split(r"\").last;
          }
          emit(EditCategoriesSuccess());
          imageFile = null;
        }
      } on Exception catch (e) {
        if (e is ClientException) {
          emit(const EditCategoriesFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(EditCategoriesFailure(
            errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      emit(const EditCategoriesFailure(
          errorMessage:
              "your offline, please turn on the internet and try again"));
    }
  }

  Future<void> deleteCategories(String categoriesId, String imageName) async {
    emit(DeleteCategoriesLoading());
    if (await checkInternetFunction()) {
      try {
        CategoriesRemote categoriesRemote = CategoriesRemote(crud);
        var response =
            await categoriesRemote.deleteCategories(categoriesId, imageName);

        String? failureMessage = handlingFailureMessage(response, "no data");
        if (failureMessage != null) {
          emit(DeleteCategoriesFailure(errorMessage: failureMessage));
        } else {
          categories
              .removeWhere((element) => element.categoriesId == categoriesId);
          emit(DeleteCategoriesSuccess());
        }
      } on Exception catch (e) {
        if (e is ClientException) {
          emit(const DeleteCategoriesFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(DeleteCategoriesFailure(
            errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      emit(const DeleteCategoriesFailure(
          errorMessage:
              "your offline, please turn on the internet and try again"));
    }
  }

  Future<void> pickImage() async {
    File? result = await pickFile(onlySvg: true);
    if (result != null) {
      imageFile = result;
      emit(ImageSuccess());
    } else {
      emit(ImageFailure());
    }
  }

  void getCategories() async {
    emit(GetCategoriesLoading());
    if (await checkInternetFunction()) {
      if (categories.isEmpty) {
        try {
          CategoriesRemote categoriesRemote = CategoriesRemote(crud);
          var response = await categoriesRemote.getCategories();
          if (response is Map<String, dynamic>) {
            categories.clear();
            for (final category in response['data']) {
              categories.add(CategoriesModel.fromJson(category));
            }
          }
          String? failureMessage = handlingFailureMessage(response, "no data");
          if (failureMessage != null) {
            emit(GetCategoriesFailure(errorMessage: failureMessage));
          } else {
            emit(GetCategoriesSuccess());
          }
        } on Exception catch (e) {
          print(e);
          if (e is ClientException) {
            emit(const GetCategoriesFailure(
                errorMessage: "the internet is slow, try again"));
          }
          emit(GetCategoriesFailure(
              errorMessage: "unknown problem : ${e.toString()} "));
        }
      } else {
        emit(GetCategoriesSuccess());
      }
    } else {
      emit(const GetCategoriesFailure(
          errorMessage:
              "your offline, please turn on the internet and try again"));
    }
  }
}
