import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:musinum/src/presentation/widget/app_container.dart';
import 'package:musinum/src/presentation/widget/app_image_widget.dart';
import 'package:musinum/src/presentation/widget/app_touchable.dart';
import 'package:musinum/src/res/image/app_image.dart';

import '../../../util/app_color.dart';
import 'intro_controller.dart';

class IntroScreen extends GetView<IntroController> {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AppImageWidget.asset(
            path: AppImage.imgBgIntro,
            height: Get.height,
            width: Get.width,
            fit: BoxFit.fill,
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: 20.sp,
              vertical: 20.sp,
            ),
            width: Get.width,
            height: Get.height * 0.45,
            decoration: BoxDecoration(
              color: AppColor.backgroundColor.withOpacity(0.98),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.sp),
                topRight: Radius.circular(50.sp),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text.rich(
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.56,
                  ),
                  TextSpan(
                    children: [
                      _buildTextSpan(
                          text: "From the ", textColor: AppColor.white),
                      _buildTextSpan(
                          text: "latest ", textColor: AppColor.blue7E5),
                      _buildTextSpan(
                          text: "to the ", textColor: AppColor.white),
                      _buildTextSpan(
                          text: "greatest ", textColor: AppColor.blue7E5),
                      _buildTextSpan(
                          text: "hits, play your favorite tracks on ",
                          textColor: AppColor.white),
                      _buildTextSpan(
                          text: "musium ", textColor: AppColor.blue7E5),
                      _buildTextSpan(text: "now ", textColor: AppColor.white),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                Gap(24.sp),
                AppTouchable(
                  onPressed: controller.onPressContinue,
                  outlinedBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0.sp),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    width: Get.width * 0.9,
                    height: 65.sp,
                    decoration: ShapeDecoration(
                      color: AppColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.sp),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: AppColor.primaryColor,
                          blurRadius: 10,
                          offset: Offset(0, 0),
                          spreadRadius: 0.50,
                        )
                      ],
                    ),
                    child: Text(
                      "Get Started",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: 18.sp,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.72,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextSpan _buildTextSpan({required String text, required Color textColor}) {
    return TextSpan(
      text: text,
      style: TextStyle(
        color: textColor,
      ),
    );
  }
}
