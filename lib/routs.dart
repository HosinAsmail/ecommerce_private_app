import 'package:ecommerce_private_app/core/constant/routes.dart';
import 'package:ecommerce_private_app/core/middleware/my_middleware.dart';
import 'package:ecommerce_private_app/view/screens/ads/ad_details_screen.dart';
import 'package:ecommerce_private_app/view/screens/ads/ads_screen.dart';
import 'package:ecommerce_private_app/view/screens/ads/edit_ads_screen.dart';
import 'package:ecommerce_private_app/view/screens/categories/categories_screen.dart';
import 'package:ecommerce_private_app/view/screens/categories/edit_categories_screen.dart';
import 'package:ecommerce_private_app/view/screens/home_screen.dart';
import 'package:ecommerce_private_app/view/screens/language_screen.dart';
import 'package:ecommerce_private_app/view/screens/products/add_product_screen.dart';
import 'package:ecommerce_private_app/view/screens/products/edit_products_screen.dart';
import 'package:ecommerce_private_app/view/screens/products/product_details_screen.dart';
import 'package:ecommerce_private_app/view/screens/products/products_screen.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
      name: "/",
      page: () => const LanguageScreen(),
      middlewares: [MyMiddleWare()]),
  GetPage(name: AppRoute.homeScreen, page: () => const HomeScreen()),
  GetPage(
      name: AppRoute.categoriesScreen, page: () => const CategoriesScreen()),
  GetPage(
      name: AppRoute.editCategoriesScreen,
      page: () => const EditCategoriesScreen()),
    GetPage(
      name: AppRoute.adsScreen, page: () => const AdsScreen()),
  GetPage(
     name: AppRoute.editAdsScreen,
      page: () => const EditAdsScreen()),
      GetPage(
     name: AppRoute.adsDetailsScreen,
      page: () => const AdDetailsScreen()),
    
  GetPage(name: AppRoute.productsScreen, page: () => const ProductsScreen()),
  GetPage(
      name: AppRoute.editProductsScreen,
      page: () => const EditProductsScreen()),
  GetPage(
      name: AppRoute.addProductsScreen, page: () => const AddProductsScreen()),
  GetPage(
      name: AppRoute.productDetailsScreen, page: () => const ProductDetailsScreen()),

];
