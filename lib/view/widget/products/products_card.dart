import 'package:ecommerce_private_app/core/constant/app_color.dart';
import 'package:ecommerce_private_app/core/constant/app_links.dart';
import 'package:ecommerce_private_app/core/constant/routes.dart';
import 'package:ecommerce_private_app/core/functions/alert_dialog.dart';
import 'package:ecommerce_private_app/cubits/products%20cubit/products_cubit.dart';
import 'package:ecommerce_private_app/data/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.productsModel,
  });

  final ProductsModel productsModel;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      onTap: () {
        Get.toNamed(AppRoute.productDetailsScreen,
            arguments: {"productModel": productsModel});
      },
      leading: Container(
        height: 200,
        width: 100,
        decoration: BoxDecoration(
            color: AppColor.secondaryColor,
            borderRadius: BorderRadius.circular(10)),
        child: Hero(
          tag: productsModel.productsId!,
          child: Image.network(
            "${AppLinks.imageProductsLink}/${productsModel.productsImage}",
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              }
            },
            height: 200,
            width: 100,
          ),
        ),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                alertDialog(
                    context: context,
                    title: "تنبيه",
                    content: "هل أنت متأكد من أنك تريد حذف هذا المنتج",
                    confirmText: "نعم",
                    onPressed: () {
                      context.read<ProductsCubit>().deleteProducts(
                          productsModel.productsId!,
                          productsModel.productsImage!);
                      Get.back();
                    });
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Get.toNamed(AppRoute.editProductsScreen,
                    arguments: {"productsModel": productsModel});
              },
            ),
          ],
        ),
      ),
      title: Text(
          "${productsModel.productsNameAr!}    ${productsModel.productsName!}    "),
      subtitle: Text(productsModel.productsDatetime!),
    ));
  }
}
