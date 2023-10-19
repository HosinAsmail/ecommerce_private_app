import 'package:ecommerce_private_app/core/constant/app_color.dart';
import 'package:ecommerce_private_app/core/functions/alert_loading.dart';
import 'package:ecommerce_private_app/core/functions/close_loading_dialog.dart';
import 'package:ecommerce_private_app/core/functions/my_snack_bar.dart';
import 'package:ecommerce_private_app/cubits/categories%20cubit/categories_cubit.dart';
import 'package:ecommerce_private_app/view/widget/Language/custom_language_button.dart';
import 'package:ecommerce_private_app/view/widget/auth/custom_button_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_private_app/core/functions/valid_input_function.dart';
import 'package:ecommerce_private_app/view/widget/auth/custom_text_field_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class AddCategoryForm extends StatelessWidget {
  const AddCategoryForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController englishNameControl = TextEditingController();
    final TextEditingController arabicNameControl = TextEditingController();
    return BlocListener<CategoriesCubit, CategoriesState>(
        listener: (context, state) {
          if (state is AddCategoriesLoading) {
            alertLoading();
          } else if (state is AddCategoriesFailure) {
            closeLoadingDialog();
            mySnackBar(Colors.red, "خطأ", state.errorMessage);
            print(state.errorMessage);
          } else if (state is AddCategoriesSuccess) {
            closeLoadingDialog();
            Get.back();
            mySnackBar(AppColor.successColor, 'نجاح', 'تمت إضافة القسم بنجاح');
          } else if (state is ImageSuccess) {
            mySnackBar(
                AppColor.successColor, "نجاح", "تم  اختيار الصورة بنجاح");
          } else if (state is ImageFailure) {
            mySnackBar(AppColor.secondaryColor, "تنبيه", "انت لم تختر الصورة");
          }
        },
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                CustomTextFieldAuth(
                    hintText: "اسم القسم بالانجليزي",
                    label: "اسم القسم بالانجليزي",
                    iconData: Icons.info,
                    controller: englishNameControl,
                    validator: (value) {
                      return validInput(value!.trim(), 1, 100, 'name');
                    },
                    keyboardType: TextInputType.name),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFieldAuth(
                    hintText: "اسم القسم بالعربي",
                    label: "اسم القسم بالعربي",
                    iconData: Icons.info,
                    controller: arabicNameControl,
                    validator: (value) {
                      return validInput(value!.trim(), 1, 100, 'name');
                    },
                    keyboardType: TextInputType.name),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButtonAuth(
                        onPressed: () async {
                          await context.read<CategoriesCubit>().pickImage();
                        },
                        text: "حمل صورة"),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, top: 10),
                      child: BlocBuilder<CategoriesCubit, CategoriesState>(
                        buildWhen: (previous, current) {
                          if (current is ImageFailure ||
                              current is ImageSuccess ||
                              current is AddCategoriesSuccess) {
                            return true;
                          } else {
                            return false;
                          }
                        },
                        builder: (context, state) {
                          return Checkbox(
                              activeColor: Colors.green,
                              value:
                                  context.read<CategoriesCubit>().imageFile ==
                                          null
                                      ? false
                                      : true,
                              onChanged: (value) {});
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomLanguageButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (context.read<CategoriesCubit>().imageFile != null) {
                          context.read<CategoriesCubit>().addCategories(
                              englishNameControl.text, arabicNameControl.text);
                        } else {
                          mySnackBar(Colors.red, "خطأ", "الرجاء إضافة الصورة");
                        }
                      }
                    },
                    textButton: 'إضافة القسم')
              ],
            ),
          ),
        ));
  }
}
