import 'package:ecommerce_private_app/core/constant/app_theme.dart';
import 'package:ecommerce_private_app/core/services/init%20services/init_services.dart';
import 'package:ecommerce_private_app/cubits/ads%20cubit/ads_cubit.dart';
import 'package:ecommerce_private_app/cubits/categories%20cubit/categories_cubit.dart';
import 'package:ecommerce_private_app/cubits/locale%20cubit/locale_cubit.dart';
import 'package:ecommerce_private_app/cubits/products%20cubit/products_cubit.dart';
import 'package:ecommerce_private_app/debug/app_bloc_observer.dart';
import 'package:ecommerce_private_app/routs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await InitServices().init();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => LocaleCubit()),
    BlocProvider(create: (context) => CategoriesCubit()),
    BlocProvider(create: (context) => AdsCubit()),
    BlocProvider(create: (context) => ProductsCubit
    ()),

  ], child: const EcommerceApp()));
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleChange>(
      // buildWhen:(pre,current){
      //   if(current.locale.languageCode =='ar' ){
      //     return true;
      //   }else{
      //     return false;
      //   }
      // },
      builder: (context, state) {
        return GetMaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          theme: arabicTheme,
          debugShowCheckedModeBanner: false,
          locale: const Locale('ar'),
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (deviceLocale != null &&
                  deviceLocale.languageCode == locale.languageCode) {
                return deviceLocale;
              }
            }

            return supportedLocales.first;
          },
          getPages: routes,
        );
      },
    );
  }
}
