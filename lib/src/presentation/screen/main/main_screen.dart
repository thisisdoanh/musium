import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:musinum/src/presentation/screen/main/widget/tab_explore.dart';
import 'package:musinum/src/presentation/screen/main/widget/tab_home.dart';
import 'package:musinum/src/presentation/widget/app_container.dart';
import 'package:musinum/src/presentation/widget/app_image_widget.dart';
import 'package:musinum/src/res/image/app_image.dart';
import 'package:musinum/src/util/app_color.dart';

import '../../../res/string/string_constants.dart';
import '../../widget/app_touchable.dart';
import 'main_controller.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      color: AppColor.black,
      width: Get.width,
      height: 70.sp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () => AppTouchable(
              onPressed: () {
                controller.currentTabIndex.value = 0;
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppImageWidget.asset(
                    path: AppImage.icHome,
                    height: 20.sp,
                    color: controller.currentTabIndex.value == 0
                        ? AppColor.primaryColor
                        : AppColor.white,
                  ),
                  Gap(4.sp),
                  Text(
                    StringConstants.home.tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: controller.currentTabIndex.value == 0
                          ? AppColor.primaryColor
                          : AppColor.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.60,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => AppTouchable(
              onPressed: () {
                controller.currentTabIndex.value = 1;
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppImageWidget.asset(
                    path: AppImage.icSearch,
                    color: controller.currentTabIndex.value == 1
                        ? AppColor.primaryColor
                        : AppColor.white,
                    height: 20.sp,
                  ),
                  Gap(4.sp),
                  Text(
                    StringConstants.explore.tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: controller.currentTabIndex.value == 1
                          ? AppColor.primaryColor
                          : AppColor.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.60,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      bottomNavigationBar: _buildBottomNavigationBar(context),
      child: Stack(
        children: [
          Positioned(
            top: -80.sp,
            child: Container(
              width: Get.width,
              height: 350.sp,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  end: Alignment(0.00, -1.00),
                  begin: Alignment(0, 1),
                  colors: [
                    Color(0x000D0D0D),
                    Color(0xFF0F2B2C),
                    Color(0xFF059FB4),
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => Positioned.fill(
              child: controller.currentTabIndex.value == 0
                  ? const TabHome()
                  : const TabExplore(),
            ),
          ),
        ],
      ),
    );
  }
}
