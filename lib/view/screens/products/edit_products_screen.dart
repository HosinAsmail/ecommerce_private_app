import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:ecommerce_private_app/core/constant/app_color.dart';
import 'package:ecommerce_private_app/core/functions/alert_loading.dart';
import 'package:ecommerce_private_app/core/functions/close_loading_dialog.dart';
import 'package:ecommerce_private_app/core/functions/my_snack_bar.dart';
import 'package:ecommerce_private_app/core/functions/translate_from_database.dart';
import 'package:ecommerce_private_app/core/shared/custom_drop_down_search.dart';
import 'package:ecommerce_private_app/cubits/categories%20cubit/categories_cubit.dart'
    as categories_cubit;
import 'package:ecommerce_private_app/cubits/products%20cubit/products_cubit.dart';
import 'package:ecommerce_private_app/data/model/categories_model.dart';
import 'package:ecommerce_private_app/data/model/products_model.dart';
import 'package:ecommerce_private_app/view/widget/Language/custom_language_button.dart';
import 'package:ecommerce_private_app/view/widget/auth/custom_button_auth.dart';
import 'package:ecommerce_private_app/view/widget/products/drop_down_state_button.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_private_app/core/functions/valid_input_function.dart';
import 'package:ecommerce_private_app/view/widget/auth/custom_text_field_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class EditProductsScreen extends StatelessWidget {
  const EditProductsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController englishNameControl = TextEditingController();
    final TextEditingController arabicNameControl = TextEditingController();
    final TextEditingController englishDescControl = TextEditingController();
    final TextEditingController arabicDescArControl = TextEditingController();
    final TextEditingController countControl = TextEditingController();
    final TextEditingController priceControl = TextEditingController();
    final TextEditingController discountControl = TextEditingController();
    final TextEditingController stateControl = TextEditingController();

    final TextEditingController productsCategoriesControl =
        TextEditingController();
    final TextEditingController categoriesIdControl = TextEditingController();
    context.read<categories_cubit.CategoriesCubit>().getCategories();
    ProductsModel productsModel = Get.arguments["productsModel"];
    englishNameControl.text = productsModel.productsName!;
    arabicNameControl.text = productsModel.productsNameAr!;
    englishDescControl.text = productsModel.productsDescription!;
    arabicDescArControl.text = productsModel.productsDescriptionAr!;
    countControl.text = productsModel.productsCount!;
    priceControl.text = productsModel.productsPrice!;
    discountControl.text = productsModel.productsDiscount!;
    categoriesIdControl.text = productsModel.productsCategories!;
    stateControl.text = "${productsModel.productsActive!} previous data";

    return Scaffold(
        appBar: AppBar(
          title: const Text("تعديل المنتج"),
        ),
        body: BlocListener<ProductsCubit, ProductsState>(
            listener: (context, state) {
              if (state is EditProductsLoading) {
                alertLoading();
              } else if (state is EditProductsFailure) {
                closeLoadingDialog();
                mySnackBar(Colors.red, "خطأ", state.errorMessage);
                print(state.errorMessage);
              } else if (state is EditProductsSuccess) {
                closeLoadingDialog();
                Get.back();
                mySnackBar(
                    AppColor.successColor, 'نجاح', 'تم تعديل المنتج بنجاح');
              } else if (state is ImageSuccess) {
                mySnackBar(
                    AppColor.successColor, "نجاح", "تم  اختيار الصورة بنجاح");
              } else if (state is ImageFailure) {
                mySnackBar(
                    AppColor.secondaryColor, "تنبيه", "انت لم تختر أي صورة");
              }
            },
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView(
                  children: [
                    CustomTextFieldAuth(
                        hintText: "اسم المنتج بالانجليزي",
                        label: "اسم المنتج بالانجليزي",
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
                        hintText: "اسم المنتج بالعربي",
                        label: "اسم المنتج بالعربي",
                        iconData: Icons.info,
                        controller: arabicNameControl,
                        validator: (value) {
                          return validInput(value!.trim(), 1, 100, 'name');
                        },
                        keyboardType: TextInputType.name),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFieldAuth(
                        hintText: "وصف المنتج بالانجليزي",
                        label: "وصف المنتج بالانجليزي",
                        iconData: Icons.info,
                        controller: englishDescControl,
                        validator: (value) {
                          return validInput(value!.trim(), 1, 100, 'name');
                        },
                        keyboardType: TextInputType.text),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFieldAuth(
                        hintText: "وصف المنتج بالعربي",
                        label: "وصف المنتج بالعربي",
                        iconData: Icons.info,
                        controller: arabicDescArControl,
                        validator: (value) {
                          return validInput(value!.trim(), 1, 100, 'name');
                        },
                        keyboardType: TextInputType.text),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFieldAuth(
                        hintText: "العدد",
                        label: "العدد",
                        iconData: Icons.info,
                        controller: countControl,
                        validator: (value) {
                          return validInput(value!.trim(), 1, 100, 'name');
                        },
                        keyboardType: TextInputType.number),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFieldAuth(
                        hintText: "السعر",
                        label: "السعر",
                        iconData: Icons.info,
                        controller: priceControl,
                        validator: (value) {
                          return validInput(value!.trim(), 1, 100, 'name');
                        },
                        keyboardType: TextInputType.number),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<categories_cubit.CategoriesCubit,
                        categories_cubit.CategoriesState>(
                      builder: (context, state) {
                        if (state is categories_cubit.GetCategoriesLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          List<CategoriesModel> categories = context
                              .read<categories_cubit.CategoriesCubit>()
                              .categories;
                          List<SelectedListItem> selectedListItems = [];
                          for (final category in categories) {
                            selectedListItems.add(SelectedListItem(
                                name: translateFromDatabase(
                                    category.categoriesNameAr!,
                                    category.categoriesName!),
                                value: category.categoriesId));
                          }
                          int index = categories.indexWhere((element) =>
                              element.categoriesId ==
                              productsModel.productsCategories);
                          productsCategoriesControl.text =
                              translateFromDatabase(
                                  categories[index].categoriesNameAr!,
                                  categories[index].categoriesName!);
                          return CustomDropDownSearch(
                              categoriesIdControl: categoriesIdControl,
                              title: "اختر قسماً",
                              data: selectedListItems,
                              dropDownControl: productsCategoriesControl);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 110,
                          child: CustomTextFieldAuth(
                              hintText: "الخصم",
                              label: "الخصم",
                              controller: discountControl,
                              validator: (value) {
                                return validInput(
                                    value!.trim(), 1, 3, 'discount');
                              },
                              keyboardType: TextInputType.number),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "%",
                          style: TextStyle(fontSize: 30),
                        ),
                        const Spacer(),
                        const Text("الحالة"),
                        const SizedBox(
                          width: 20,
                        ),
                        DropDownStateButton(stateControl: stateControl)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButtonAuth(
                            onPressed: () async {
                              await context.read<ProductsCubit>().pickImage();
                            },
                            text: "حمل صورة"),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, top: 10),
                          child: BlocBuilder<ProductsCubit, ProductsState>(
                            buildWhen: (previous, current) {
                              if (current is ImageFailure ||
                                  current is ImageSuccess) {
                                return true;
                              } else {
                                return false;
                              }
                            },
                            builder: (context, state) {
                              return Checkbox(
                                  activeColor: Colors.green,
                                  value:
                                      context.read<ProductsCubit>().imageFile ==
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
                            context.read<ProductsCubit>().editProducts(
                                productsModel.productsId!,
                                englishNameControl.text,
                                arabicNameControl.text,
                                englishDescControl.text,
                                arabicDescArControl.text,
                                countControl.text,
                                priceControl.text,
                                discountControl.text,
                                stateControl.text,
                                categoriesIdControl.text,
                                productsModel.productsImage!);
                          }
                        },
                        textButton: 'حفظ التعديلات')
                  ],
                ),
              ),
            )));
  }
}
