import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:musinum/src/presentation/widget/app_container.dart';
import 'package:musinum/src/presentation/widget/app_image_widget.dart';
import 'package:musinum/src/res/image/app_image.dart';

import 'splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return AppContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppImageWidget.asset(
            path: AppImage.imgLogo,
            width: Get.width / 2.5,
            height: Get.width / 2.5,
            fit: BoxFit.cover,
          ),
          Gap(8.sp),
          AppImageWidget.asset(
            path: AppImage.imgAppName,
            width: Get.width * 0.5,
          ),
        ],
      ),
    );
  }
}
