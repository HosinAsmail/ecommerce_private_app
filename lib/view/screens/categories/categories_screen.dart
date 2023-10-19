import 'package:ecommerce_private_app/core/constant/app_color.dart';
import 'package:ecommerce_private_app/core/functions/alert_loading.dart';
import 'package:ecommerce_private_app/core/functions/close_loading_dialog.dart';
import 'package:ecommerce_private_app/core/functions/my_snack_bar.dart';
import 'package:ecommerce_private_app/cubits/categories%20cubit/categories_cubit.dart';
import 'package:ecommerce_private_app/data/model/categories_model.dart';
import 'package:ecommerce_private_app/view/widget/categories/add_category_form.dart';
import 'package:ecommerce_private_app/view/widget/categories/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الأقسام")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return const AddCategoryForm();
              });
        },
        backgroundColor: AppColor.primaryColor,
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<CategoriesCubit, CategoriesState>(
        listener: (context, state) {
          if (state is GetCategoriesFailure) {
            mySnackBar(Colors.red, 'Failure', state.errorMessage);
          } else if (state is DeleteCategoriesLoading) {
            alertLoading();
          } else if (state is DeleteCategoriesFailure) {
            closeLoadingDialog();
            mySnackBar(Colors.red, "خطأ", state.errorMessage);
            print(state.errorMessage);
          } else if (state is DeleteCategoriesSuccess) {
            closeLoadingDialog();
            mySnackBar(AppColor.successColor, 'نجاح', 'تم حذف القسم بنجاح');
          }
        },
        buildWhen: (previous, current) {
          if (current is GetCategoriesFailure ||
              current is GetCategoriesLoading ||
              current is GetCategoriesSuccess ||
              current is DeleteCategoriesSuccess ||
              current is AddCategoriesSuccess ||
              current is EditCategoriesSuccess) {
            return true;
          } else {
            return false;
          }
        },
        builder: (context, state) {
          if (state is GetCategoriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<CategoriesModel> categories =
                context.read<CategoriesCubit>().categories;
            if (categories.isNotEmpty) {
              return ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    CategoriesModel categoriesModel = categories[index];
                    return CategoryCard(categoriesModel: categoriesModel);
                  });
            } else {
              return const Text("empty");
            }
          }
        },
      ),
    );
  }
}
