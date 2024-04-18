import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musinum/src/data/model/app_response.dart';
import 'package:musinum/src/presentation/app/app_binding.dart';
import 'package:musinum/src/presentation/router/app_router.dart';
import 'package:musinum/src/util/app_color.dart';
import 'package:musinum/src/util/app_constant.dart';
import 'package:musinum/src/util/share_preference_utils.dart';

import 'src/presentation/router/app_page.dart';
import 'src/res/string/app_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();

  await Hive.initFlutter();
  Hive.registerAdapter<AppResponse>(AppResponseAdapter());
  runApp(
    ScreenUtilInit(
      designSize: const Size(433, 922),
      builder: (context, child) {
        MediaQueryData mediaQueryData = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQueryData.copyWith(textScaler: const TextScaler.linear(1)),
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialBinding: AppBinding(),
            initialRoute: AppRouter.splashScreen,
            defaultTransition: Transition.fade,
            getPages: AppPage.pages,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            translations: AppStrings(),
            supportedLocales: AppConstant.availableLocales,
            locale: AppConstant.availableLocales[0],
            fallbackLocale: AppConstant.availableLocales[0],
            theme: ThemeData(
              primaryColor: AppColor.primaryColor,
              fontFamily: 'Century-Gothic',
              textSelectionTheme: const TextSelectionThemeData(
                selectionHandleColor: AppColor.transparent,
              ),
            ),
          ),
        );
      },
    ),
  );
}
