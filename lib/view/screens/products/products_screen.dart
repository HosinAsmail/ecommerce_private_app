import 'package:ecommerce_private_app/core/constant/app_color.dart';
import 'package:ecommerce_private_app/core/constant/routes.dart';
import 'package:ecommerce_private_app/core/functions/alert_loading.dart';
import 'package:ecommerce_private_app/core/functions/close_loading_dialog.dart';
import 'package:ecommerce_private_app/core/functions/my_snack_bar.dart';
import 'package:ecommerce_private_app/cubits/products%20cubit/products_cubit.dart';
import 'package:ecommerce_private_app/view/widget/products/products_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../data/model/products_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("المنتجات")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoute.addProductsScreen);
        },
        backgroundColor: AppColor.primaryColor,
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<ProductsCubit, ProductsState>(
        listener: (context, state) {
          if (state is GetProductsFailure) {
            mySnackBar(Colors.red, 'Failure', state.errorMessage);
          } else if (state is DeleteProductsLoading) {
            alertLoading();
          } else if (state is DeleteProductsFailure) {
            closeLoadingDialog();
            mySnackBar(Colors.red, "خطأ", state.errorMessage);
            print(state.errorMessage);
          } else if (state is DeleteProductsSuccess) {
            closeLoadingDialog();
            mySnackBar(AppColor.successColor, 'نجاح', 'تم حذف المنتج بنجاح');
          }
        },
        buildWhen: (previous, current) {
          if (current is GetProductsFailure ||
              current is GetProductsLoading ||
              current is GetProductsSuccess ||
              current is DeleteProductsSuccess ||
              current is AddProductsSuccess ||
              current is EditProductsSuccess) {
            return true;
          } else {
            return false;
          }
        },
        builder: (context, state) {
          if (state is GetProductsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<ProductsModel> products =
                context.read<ProductsCubit>().products;
            if (products.isNotEmpty) {
              return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    ProductsModel productsModel = products[index];
                    return ProductCard(productsModel: productsModel);
                  });
            } else {
              return const Text("empty");
            }
          }
        },
      ),
    );
  }
}
