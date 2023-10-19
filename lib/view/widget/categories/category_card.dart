import 'package:ecommerce_private_app/core/constant/app_color.dart';
import 'package:ecommerce_private_app/core/constant/app_links.dart';
import 'package:ecommerce_private_app/core/constant/routes.dart';
import 'package:ecommerce_private_app/core/functions/alert_dialog.dart';
import 'package:ecommerce_private_app/cubits/categories%20cubit/categories_cubit.dart';
import 'package:ecommerce_private_app/data/model/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.categoriesModel,
  });

  final CategoriesModel categoriesModel;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Container(
        height: 200,
        width: 100,
        decoration: BoxDecoration(
            color: AppColor.secondaryColor,
            borderRadius: BorderRadius.circular(10)),
        child: SvgPicture.network(
          "${AppLinks.imageCategoriesLink}/${categoriesModel.categoriesImage}",
          height: 200,
          width: 100,
        ),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                alertDialog(
                    context: context,
                    title: "تنبيه",
                    content: "هل أنت متأكد من أنك تريد حذف هذا القسم",
                    confirmText: "نعم",
                    onPressed: () {
                      context.read<CategoriesCubit>().deleteCategories(
                          categoriesModel.categoriesId!,
                          categoriesModel.categoriesImage!);
                      Get.back();
                    });
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Get.toNamed(AppRoute.editCategoriesScreen,
                    arguments: {"categoriesModel": categoriesModel});
              },
            ),
          ],
        ),
      ),
      title: Text(
          "${categoriesModel.categoriesNameAr!}    ${categoriesModel.categoriesName!}    "),
      subtitle: Text(categoriesModel.categoriesDateTime!),
    ));
  }
}
