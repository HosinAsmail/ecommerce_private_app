import 'package:ecommerce_private_app/data/model/ads_model.dart';
import 'package:ecommerce_private_app/view/widget/ads/surprise_box.dart';
import 'package:ecommerce_private_app/view/widget/home/custom_text_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdDetailsScreen extends StatelessWidget {
  const AdDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final AdsModel adsModel = arguments['AdsModel'];
    return Scaffold(
      appBar: AppBar(title: const Text("تفاصيل الإعلان")),
      body: SafeArea(
        child: ListView(
          children: [
            SurpriseBox(adModel: adsModel),
            Container(
              padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const CustomTextHome(text: "العنوان بالانجليزي"),
                  Text(
                    "${adsModel.adsTitle} ",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  const CustomTextHome(text: "العنوان بالعربي"),
                  Text(
                    "${adsModel.adsTitleAr!} ",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  const CustomTextHome(text: "المضمون بالانجليزي"),
                  Text(
                    "${adsModel.adsBody!} ",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  const CustomTextHome(text: "المضمون بالعربي"),
                  Text(
                    "${adsModel.adsBodyAr!} ",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
