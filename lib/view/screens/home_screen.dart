import 'package:ecommerce_private_app/core/constant/app_image_asset.dart';
import 'package:ecommerce_private_app/core/constant/routes.dart';
import 'package:ecommerce_private_app/cubits/ads%20cubit/ads_cubit.dart';
import 'package:ecommerce_private_app/cubits/categories%20cubit/categories_cubit.dart';
import 'package:ecommerce_private_app/cubits/products%20cubit/products_cubit.dart';
import 'package:ecommerce_private_app/view/widget/home/custom_card_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الصفحة الرئيسية")),
      body: ListView(
        children: [
          GridView(
            padding: const EdgeInsets.only(top: 10),
            physics:
                const NeverScrollableScrollPhysics(), // because we are in the list view
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.7, crossAxisCount: 3),
            children: [
              CustomHomeCard(
                  appImageAsset: AppImageAsset.logo,
                  text: "الأقسام",
                  onTap: () {
                    Get.toNamed(AppRoute.categoriesScreen);
                    context.read<CategoriesCubit>().getCategories();
                  }),
              CustomHomeCard(
                  appImageAsset: AppImageAsset.logo,
                  text: "المنتجات",
                  onTap: () {
                    Get.toNamed(AppRoute.productsScreen);
                    context.read<ProductsCubit>().getProducts();
                  }),
              CustomHomeCard(
                  appImageAsset: AppImageAsset.logo,
                  text: "الإعلانات",
                  onTap: () {
                    Get.toNamed(AppRoute.adsScreen);
                    context.read<AdsCubit>().getAds();
                  }),
            ],
          )
        ],
      ),
    );
  }
}
