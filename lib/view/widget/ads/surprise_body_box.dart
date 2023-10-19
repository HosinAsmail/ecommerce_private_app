import 'package:ecommerce_private_app/core/extension/number_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_private_app/core/functions/translate_from_database.dart';
import 'package:ecommerce_private_app/data/model/ads_model.dart';

class SurpriseBodyBox extends StatelessWidget {
  const SurpriseBodyBox({
    super.key,
    required this.adModel,
  });
  final AdsModel adModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 150,
      width: Get.width,
      decoration: BoxDecoration(
          color: Color(adModel.adsColor!.toInt()),
          borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        title: Text(
            translateFromDatabase(adModel.adsTitleAr!, adModel.adsTitle!),
            style: const TextStyle(color: Colors.white, fontSize: 20)),
        subtitle: Text(
            translateFromDatabase(adModel.adsBodyAr!, adModel.adsBody!),
            style: const TextStyle(color: Colors.white, fontSize: 30)),
      ),
    );
  }
}
