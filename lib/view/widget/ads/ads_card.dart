// import 'package:ecommerce_private_app/core/constant/app_color.dart';
// import 'package:ecommerce_private_app/core/constant/app_links.dart';
// import 'package:ecommerce_private_app/core/constant/routes.dart';
// import 'package:ecommerce_private_app/core/functions/alert_dialog.dart';
// import 'package:ecommerce_private_app/cubits/ads%20cubit/ads_cubit.dart';
// import 'package:ecommerce_private_app/data/model/ads_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';

// class AdCard extends StatelessWidget {
//   const AdCard({
//     super.key,
//     required this.adsModel,
//   });

//   final AdsModel adsModel;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//         child: ListTile(
//       leading: const Text("none"),
//       trailing: SizedBox(
//         width: 100,
//         child: Row(
//           children: [
//             const Spacer(),
//             IconButton(
//               icon: const Icon(Icons.delete),
//               onPressed: () {
//                 alertDialog(
//                     context: context,
//                     title: "تنبيه",
//                     content: "هل أنت متأكد من أنك تريد حذف هذا القسم",
//                     confirmText: "نعم",
//                     onPressed: () {
//                       context.read<AdsCubit>().deleteAds(adsModel.adsId!);
//                       Get.back();
//                     });
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.edit),
//               onPressed: () {
//                 Get.toNamed(AppRoute.editAdsScreen,
//                     arguments: {"AdsModel": AdsModel});
//               },
//             ),
//           ],
//         ),
//       ),
//       title: Text("${adsModel.adsTitle!}    ${adsModel.adsTitleAr!}    "),
//       subtitle: Text(adsModel.adsDatatime!),
//     ));
//   }
// }
