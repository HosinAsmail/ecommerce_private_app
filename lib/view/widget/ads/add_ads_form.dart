import 'package:ecommerce_private_app/core/constant/app_color.dart';
import 'package:ecommerce_private_app/core/functions/alert_loading.dart';
import 'package:ecommerce_private_app/core/functions/close_loading_dialog.dart';
import 'package:ecommerce_private_app/core/functions/my_snack_bar.dart';
import 'package:ecommerce_private_app/cubits/ads%20cubit/ads_cubit.dart';
import 'package:ecommerce_private_app/view/widget/Language/custom_language_button.dart';
import 'package:ecommerce_private_app/view/widget/ads/choose_color.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_private_app/core/functions/valid_input_function.dart';
import 'package:ecommerce_private_app/view/widget/auth/custom_text_field_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class AddAdForm extends StatelessWidget {
  const AddAdForm({
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

    return BlocListener<AdsCubit, AdsState>(
        listener: (context, state) {
          if (state is AddAdsLoading) {
            alertLoading();
          } else if (state is AddAdsFailure) {
            closeLoadingDialog();
            mySnackBar(Colors.red, "خطأ", state.errorMessage);
            print(state.errorMessage);
          } else if (state is AddAdsSuccess) {
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
            child: ListView(
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
                      if (circleColorControl.text.isNotEmpty &&
                          mainColorControl.text.isNotEmpty) {
                      context.read<AdsCubit>().addAds(
                          englishTitleControl.text,
                          arabicTitleControl.text,
                          englishBodyControl.text,
                          arabicBodyControl.text,
                           mainColorControl.text,
                           circleColorControl.text
                          );
                      } else {
                        mySnackBar(Colors.red, "خطأ", "الرجاء اختيار الألون");
                      }
                      }
                    },
                    textButton: 'إضافة الإعلان')
              ],
            ),
          ),
        ));
  }
}
