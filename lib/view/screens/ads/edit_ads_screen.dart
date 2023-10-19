import 'package:ecommerce_private_app/core/constant/app_color.dart';
import 'package:ecommerce_private_app/core/functions/alert_loading.dart';
import 'package:ecommerce_private_app/core/functions/close_loading_dialog.dart';
import 'package:ecommerce_private_app/core/functions/my_snack_bar.dart';
import 'package:ecommerce_private_app/cubits/ads%20cubit/ads_cubit.dart';
import 'package:ecommerce_private_app/data/model/ads_model.dart';
import 'package:ecommerce_private_app/view/widget/Language/custom_language_button.dart';
import 'package:ecommerce_private_app/view/widget/ads/choose_color.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_private_app/core/functions/valid_input_function.dart';
import 'package:ecommerce_private_app/view/widget/auth/custom_text_field_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class EditAdsScreen extends StatelessWidget {
  const EditAdsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController englishTitleControl = TextEditingController();
    final TextEditingController arabicTitleControl = TextEditingController();
    final TextEditingController englishBodyControl = TextEditingController();
    final TextEditingController arabicBodyControl = TextEditingController();
    final TextEditingController mainColorControl = TextEditingController();
    final TextEditingController circleColorControl = TextEditingController();
    AdsModel adsModel = Get.arguments["AdsModel"];
    englishTitleControl.text = adsModel.adsTitle!;
    arabicTitleControl.text = adsModel.adsTitleAr!;
    englishBodyControl.text = adsModel.adsBody!;
    arabicBodyControl.text = adsModel.adsBodyAr!;
    mainColorControl.text = "${adsModel.adsColor!} color";
    circleColorControl.text = "${adsModel.adsColorCircle!} color";

    return Scaffold(
        appBar: AppBar(
          title: const Text("تعديل الإعلان"),
        ),
        body: BlocListener<AdsCubit, AdsState>(
            listener: (context, state) {
              if (state is EditAdsLoading) {
                alertLoading();
              } else if (state is EditAdsFailure) {
                closeLoadingDialog();
                mySnackBar(Colors.red, "خطأ", state.errorMessage);
                print(state.errorMessage);
              } else if (state is EditAdsSuccess) {
                closeLoadingDialog();
                Get.back();
                mySnackBar(
                    AppColor.successColor, 'نجاح', 'تمت إضافة الإعلان بنجاح');
              }
            },
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    CustomTextFieldAuth(
                        hintText: "عنوان الإعلان بالانجليزي",
                        label: "عنوان الإعلان بالانجليزي",
                        iconData: Icons.info,
                        controller: englishTitleControl,
                        validator: (value) {
                          return validInput(value!.trim(), 1, 100, 'name');
                        },
                        keyboardType: TextInputType.name),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFieldAuth(
                        hintText: "عنوان الإعلان بالعربي",
                        label: "عنوان الإعلان بالعربي",
                        iconData: Icons.info,
                        controller: arabicTitleControl,
                        validator: (value) {
                          return validInput(value!.trim(), 1, 100, 'name');
                        },
                        keyboardType: TextInputType.name),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFieldAuth(
                        hintText: "مضمون الإعلان بالإنجليزي",
                        label: "مضمون الإعلان بالإنجليزي",
                        iconData: Icons.info,
                        controller: englishBodyControl,
                        validator: (value) {
                          return validInput(value!.trim(), 1, 100, 'name');
                        },
                        keyboardType: TextInputType.name),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFieldAuth(
                        hintText: "مضمون الإعلان بالعربي",
                        label: "مضمون الإعلان بالعربي",
                        iconData: Icons.info,
                        controller: arabicBodyControl,
                        validator: (value) {
                          return validInput(value!.trim(), 1, 100, 'name');
                        },
                        keyboardType: TextInputType.name),
                    const SizedBox(
                      height: 10,
                    ),
                    ChooseColor(
                      text: "اختر لون الخلفية",
                      mainColorControl: mainColorControl,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ChooseColor(
                      text: "  اختر لون الدائرة",
                      mainColorControl: circleColorControl,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomLanguageButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AdsCubit>().editAds(
                                adsModel.adsId!,
                                englishTitleControl.text,
                                arabicTitleControl.text,
                                englishBodyControl.text,
                                arabicBodyControl.text,
                                mainColorControl.text.substring(0, 10),
                                circleColorControl.text.substring(0, 10));
                          }
                        },
                        textButton: 'حفظ التعديلات')
                  ],
                ),
              ),
            )));
  }
}
