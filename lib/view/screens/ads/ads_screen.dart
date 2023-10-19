import 'package:ecommerce_private_app/core/constant/app_color.dart';
import 'package:ecommerce_private_app/core/functions/alert_loading.dart';
import 'package:ecommerce_private_app/core/functions/close_loading_dialog.dart';
import 'package:ecommerce_private_app/core/functions/my_snack_bar.dart';
import 'package:ecommerce_private_app/cubits/ads%20cubit/ads_cubit.dart';
import 'package:ecommerce_private_app/data/model/ads_model.dart';
import 'package:ecommerce_private_app/view/widget/ads/add_ads_form.dart';
import 'package:ecommerce_private_app/view/widget/ads/surprise_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdsScreen extends StatelessWidget {
  const AdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الإعلانات"),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AdsCubit>().getAsyncAds();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return const AddAdForm();
              });
        },
        backgroundColor: AppColor.primaryColor,
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<AdsCubit, AdsState>(
        listener: (context, state) {
          if (state is GetAdsFailure) {
            mySnackBar(Colors.red, 'Failure', state.errorMessage);
          } else if (state is DeleteAdsLoading) {
            alertLoading();
          } else if (state is DeleteAdsFailure) {
            closeLoadingDialog();
            mySnackBar(Colors.red, "خطأ", state.errorMessage);
            print(state.errorMessage);
          } else if (state is DeleteAdsSuccess) {
            closeLoadingDialog();
            mySnackBar(AppColor.successColor, 'نجاح', 'تم حذف الإعلان بنجاح');
          }
        },
        buildWhen: (previous, current) {
          if (current is GetAdsFailure ||
              current is GetAdsLoading ||
              current is GetAdsSuccess ||
              current is DeleteAdsSuccess ||
              current is AddAdsSuccess ||
              current is EditAdsSuccess) {
            return true;
          } else {
            return false;
          }
        },
        builder: (context, state) {
          if (state is GetAdsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<AdsModel> ads = context.read<AdsCubit>().ads;
            if (ads.isNotEmpty) {
              return ListView.builder(
                  itemCount: ads.length,
                  itemBuilder: (context, index) {
                    AdsModel adsModel = ads[index];

                    // print("==================================");
                    // print("color orange  ${Color(ads[0].adsColor!.toInt()).value}");
                    // print("color orange circle  ${Color(ads[0].adsColorCircle!.toInt()).value}");
                    // print("==================================");
                    // print("color blue  ${Color(ads[1].adsColor!.toInt()).value}");
                    // print("color blue circle ${Color(ads[1].adsColorCircle!.toInt()).value}");

                    return SurpriseBox(adModel: adsModel);
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
