import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_private_app/core/functions/check_internet_function.dart';
import 'package:ecommerce_private_app/core/functions/pick_file.dart';
import 'package:ecommerce_private_app/data/data%20source/remote/products_remote.dart';
import 'package:ecommerce_private_app/data/model/products_model.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

import '../../core/api/crud.dart';
import '../../core/functions/handling_failure_response.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
  Crud crud = Crud();
  List<ProductsModel> products = [];
  File? imageFile;
  void addProducts(
    String englishName,
    String arabicName,
    String englishDesc,
    String arabicDescAr,
    String count,
    String price,
    String discount,
    String active,
    String categoriesId,
  ) async {
    emit(AddProductsLoading());
    if (await checkInternetFunction()) {
      try {
        ProductsRemote productsRemote = ProductsRemote(crud);
        var response = await productsRemote.addProducts(
            englishName,
            arabicName,
            englishDesc,
            arabicDescAr,
            count,
            price,
            discount,
            active,
            categoriesId,
            imageFile!);
        if (response is Map<String, dynamic>) {
          products.add(ProductsModel.fromJson(response['data'][0]));
        }
        String? failureMessage = handlingFailureMessage(
            response, "اسم الصورة موجوج مسبقا الرجاء تغيير اسم الصورة");
        if (failureMessage != null) {
          emit(AddProductsFailure(errorMessage: failureMessage));
        } else {
          emit(AddProductsSuccess());
          imageFile = null;
        }
      } on Exception catch (e) {
        if (e is ClientException) {
          emit(const AddProductsFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(AddProductsFailure(
            errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      emit(const AddProductsFailure(
          errorMessage:
              "your offline, please turn on the internet and try again"));
    }
  }

  void editProducts(
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
      String oldImage) async {
    emit(EditProductsLoading());
    if (await checkInternetFunction()) {
      try {
        ProductsRemote productsRemote = ProductsRemote(crud);
        var response = await productsRemote.editProducts(
            productsId,
            englishName,
            arabicName,
            englishDesc,
            arabicDescAr,
            count,
            price,
            discount,
            active,
            categoriesId,
            imageFile,
            oldImage);

        String? failureMessage = handlingFailureMessage(
            response, "اسم الصورة موجوج مسبقا الرجاء تغيير اسم الصورة");
        if (failureMessage != null) {
          emit(EditProductsFailure(errorMessage: failureMessage));
        } else {
          int index = products
              .indexWhere((element) => element.productsId == productsId);
          products[index].productsName = englishName;
          products[index].productsNameAr = arabicName;
          products[index].productsDescription = englishDesc;
          products[index].productsDescriptionAr = arabicDescAr;
          products[index].productsCount = count;
          products[index].productsActive = active;
          products[index].productsPrice = price;
          products[index].productsDiscount = discount;
          products[index].productsCategories = categoriesId;

          if (imageFile != null) {
            products[index].productsImage = imageFile!.path.split(r"\").last;
          }
          emit(EditProductsSuccess());
          imageFile = null;
        }
      } on Exception catch (e) {
        if (e is ClientException) {
          emit(const EditProductsFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(EditProductsFailure(
            errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      emit(const EditProductsFailure(
          errorMessage:
              "your offline, please turn on the internet and try again"));
    }
  }

  Future<void> deleteProducts(String productsId, String imageName) async {
    emit(DeleteProductsLoading());
    if (await checkInternetFunction()) {
      try {
        ProductsRemote productsRemote = ProductsRemote(crud);
        var response =
            await productsRemote.deleteProducts(productsId, imageName);

        String? failureMessage = handlingFailureMessage(response, "no data");
        if (failureMessage != null) {
          emit(DeleteProductsFailure(errorMessage: failureMessage));
        } else {
          products.removeWhere((element) => element.productsId == productsId);
          emit(DeleteProductsSuccess());
        }
      } on Exception catch (e) {
        if (e is ClientException) {
          emit(const DeleteProductsFailure(
              errorMessage: "the internet is slow, try again"));
        }
        emit(DeleteProductsFailure(
            errorMessage: "unknown problem : ${e.toString()} "));
      }
    } else {
      emit(const DeleteProductsFailure(
          errorMessage:
              "your offline, please turn on the internet and try again"));
    }
  }

  Future<void> pickImage() async {
    File? result = await pickFile(onlySvg: false);
    if (result != null) {
      imageFile = result;
      emit(ImageSuccess());
    } else {
      emit(ImageFailure());
    }
  }

  void getProducts() async {
    emit(GetProductsLoading());
    if (await checkInternetFunction()) {
      if (products.isEmpty) {
        try {
          ProductsRemote productsRemote = ProductsRemote(crud);
          var response = await productsRemote.getProducts();
          if (response is Map<String, dynamic>) {
            products.clear();
            for (final product in response['data']) {
              products.add(ProductsModel.fromJson(product));
            }
          }
          String? failureMessage = handlingFailureMessage(response, "no data");
          if (failureMessage != null) {
            emit(GetProductsFailure(errorMessage: failureMessage));
          } else {
            emit(GetProductsSuccess());
          }
        } on Exception catch (e) {
          print(e);
          if (e is ClientException) {
            emit(const GetProductsFailure(
                errorMessage: "the internet is slow, try again"));
          }
          emit(GetProductsFailure(
              errorMessage: "unknown problem : ${e.toString()} "));
        }
      } else {
        emit(GetProductsSuccess());
      }
    } else {
      emit(const GetProductsFailure(
          errorMessage:
              "your offline, please turn on the internet and try again"));
    }
  }
}
