import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musinum/src/util/app_constant.dart';
import 'package:musinum/src/util/share_preference_utils.dart';

import '../../router/app_router.dart';

class IntroController extends GetxController {
  late BuildContext context;

  void onPressContinue() async {
    await PreferenceUtils.setBool(AppKey.keyFirstOpenApp, false);
    Get.offAndToNamed(AppRouter.homeScreen);
  }
}
