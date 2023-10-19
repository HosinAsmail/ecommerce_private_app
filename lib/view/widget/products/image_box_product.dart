import 'package:ecommerce_private_app/data/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_links.dart';

class ImageBoxProduct extends StatelessWidget {
  const ImageBoxProduct({
    super.key,
    required this.productModel,
  });

  final ProductsModel productModel;

  @override
  Widget build(BuildContext context) {

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 200,
          color: AppColor.thirdColor,
        ),
        Positioned(
          bottom: -30,
          left: 50,
          right: 50,
          child: Hero(
            tag: productModel.productsId!,
            child: Image.network(
              "${AppLinks.imageProductsLink}/${productModel.productsImage}",
              height: 200,
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
            )),
       
      ],
    );
  }
}
