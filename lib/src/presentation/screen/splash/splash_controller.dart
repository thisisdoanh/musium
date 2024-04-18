import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:musinum/src/data/model/app_response.dart';
import 'package:musinum/src/data/store/hive_data_store.dart';
import 'package:musinum/src/util/app_constant.dart';
import 'package:musinum/src/util/app_log.dart';

import '../../../data/service/api_service.dart';
import '../../../util/share_preference_utils.dart';
import '../../router/app_router.dart';

class SplashController extends GetxController {
  late BuildContext context;

  @override
  void onReady() async {
    AppLog.info("onReady SplashController");
    await Hive.openBox<AppResponse>(HiveDataStore.historyListenBoxName);
    await Future.delayed(const Duration(seconds: 3));
    bool isFirstOpenApp = PreferenceUtils.getBool(AppKey.keyFirstOpenApp) ?? true;
    await ApiService.getAuthentication();
    if (isFirstOpenApp) {
      Get.offAndToNamed(AppRouter.introScreen);
    } else {
      Get.offAndToNamed(AppRouter.homeScreen);
    }
    super.onReady();
  }
}
