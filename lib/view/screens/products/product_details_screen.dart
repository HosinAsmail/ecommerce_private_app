import 'package:ecommerce_private_app/core/functions/get_product_state.dart';
import 'package:ecommerce_private_app/cubits/categories%20cubit/categories_cubit.dart';
import 'package:ecommerce_private_app/data/model/categories_model.dart';
import 'package:ecommerce_private_app/data/model/products_model.dart';
import 'package:ecommerce_private_app/view/widget/home/custom_text_home.dart';
import 'package:ecommerce_private_app/view/widget/products/image_box_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final ProductsModel productModel = arguments['productModel'];
    context.read<CategoriesCubit>().getCategories();
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            ImageBoxProduct(productModel: productModel),
            Container(
              padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  CustomTextHome(
                    text:
                        "${productModel.productsNameAr!}     ${productModel.productsName!}",
                  ),
                  const CustomTextHome(text: "القسم"),
                  BlocBuilder<CategoriesCubit, CategoriesState>(
                    builder: (context, state) {
                      if (state is GetCategoriesLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        List<CategoriesModel> categories =
                            context.read<CategoriesCubit>().categories;
                        int index = categories.indexWhere((element) =>
                            element.categoriesId ==
                            productModel.productsCategories);
                        return Text(
                          "${categories[index].categoriesNameAr!}                  ${categories[index].categoriesName!} ",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontWeight: FontWeight.normal),
                        );
                      }
                    },
                  ),
                  const CustomTextHome(text: "الوصف بالعربي"),
                  Text(
                    "${productModel.productsDescriptionAr!} ",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  const CustomTextHome(text: "الوصف بالانجليزي"),
                  Text(
                    "${productModel.productsDescription!} ",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  const CustomTextHome(text: "الكمية"),
                  Text(
                    "${productModel.productsCount!} ",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  const CustomTextHome(text: "السعر الأصلي"),
                  Text(
                    "${productModel.productsPrice!} ",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  const CustomTextHome(text: "الخصم"),
                  Text(
                    "${productModel.productsDiscount!} % ",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  const CustomTextHome(text: "السعر بعد الخصم"),
                  Text(
                    "${productModel.discountedPrice!} ",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  const CustomTextHome(text: "الحالة"),
                  Text(
                    getProductState(productModel.productsActive!),
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  const CustomTextHome(text: "تاريخ الإضافة"),
                  Text(
                    "${productModel.productsDatetime!} ",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.normal),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
