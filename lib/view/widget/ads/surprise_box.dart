import 'package:ecommerce_private_app/core/constant/routes.dart';
import 'package:ecommerce_private_app/core/extension/number_extensions.dart';
import 'package:ecommerce_private_app/core/functions/alert_dialog.dart';
import 'package:ecommerce_private_app/cubits/ads%20cubit/ads_cubit.dart';
import 'package:ecommerce_private_app/data/model/ads_model.dart';
import 'package:ecommerce_private_app/view/widget/ads/side_circle.dart';
import 'package:ecommerce_private_app/view/widget/ads/surprise_body_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SurpriseBox extends StatelessWidget {
  const SurpriseBox({super.key, required this.adModel});
  final AdsModel adModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoute.adsDetailsScreen,
            arguments: {"AdsModel": adModel});
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Stack(children: [
          SurpriseBodyBox(
            adModel: adModel,
          ),
          SideCircle(
            color: adModel.adsColorCircle!.toInt(),
          ),
          Positioned(
              bottom: 0,
              left: Get.width / 2.4,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.toNamed(AppRoute.editAdsScreen,
                            arguments: {"AdsModel": adModel});
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 30,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () {
                        alertDialog(
                            context: context,
                            title: "تنبيه",
                            content: "هل أنت متأكد من أنك تريد حذف هذا القسم",
                            confirmText: "نعم",
                            onPressed: () {
                              context
                                  .read<AdsCubit>()
                                  .deleteAds(adModel.adsId!);
                              Get.back();
                            });
                      },
                      icon: const Icon(
                        Icons.delete,
                        size: 30,
                      )),
                ],
              ))
        ]),
      ),
    );
  }
}
