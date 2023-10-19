import 'package:ecommerce_private_app/core/constant/routes.dart';
import 'package:ecommerce_private_app/core/services/storage%20services/store_step_service.dart';
import 'package:ecommerce_private_app/view/widget/Language/custom_language_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../cubits/locale cubit/locale_cubit.dart';
import '../../generated/l10n.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                S.of(context).choose_language,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomLanguageButton(
                onPressed: () async {
                  StoreStepService().setStep("1");
                  Get.offAllNamed(AppRoute.homeScreen);

                  await context.read<LocaleCubit>().changeLocale('en');
                },
                textButton: S.of(context).en_language),
            const SizedBox(
              height: 10,
            ),
            CustomLanguageButton(
                onPressed: () async {
                  await context.read<LocaleCubit>().changeLocale('ar');
                },
                textButton: S.of(context).ar_language)
          ],
        ),
      ),
    );
  }
}
