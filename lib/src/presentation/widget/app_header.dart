import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../res/image/app_image.dart';
import '../../util/app_color.dart';
import 'app_image_widget.dart';
import 'app_touchable.dart';

class AppHeader extends StatelessWidget {
  final String? title;
  final String? hintContent;
  final String? hintTitle;
  final Widget? leftWidget;
  final Widget? rightWidget;
  final Widget? middleWidget;
  final Widget? extendWidget;
  final CrossAxisAlignment? crossAxisAlignmentMainRow;
  final Function()? onPressBack;

  const AppHeader({
    Key? key,
    this.title,
    this.leftWidget,
    this.rightWidget,
    this.middleWidget,
    this.extendWidget,
    this.crossAxisAlignmentMainRow,
    this.hintContent,
    this.hintTitle,
    this.onPressBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        0.0,
        MediaQuery.of(context).padding.top + 6.0.sp,
        0.0,
        12.0.sp,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
            child: Row(
              crossAxisAlignment:
                  crossAxisAlignmentMainRow ?? CrossAxisAlignment.center,
              children: [
                leftWidget ??
                    AppTouchable(
                      width: 40.0.sp,
                      height: 40.0.sp,
                      padding: EdgeInsets.all(2.0.sp),
                      onPressed: onPressBack ?? Get.back,
                      child: AppImageWidget.asset(
                        path: AppImage.icBack,
                      ),
                    ),
                Expanded(
                  child: middleWidget ??
                      Text(
                        title ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColor.white,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.72,
                        ),
                      ),
                ),
                rightWidget ?? SizedBox(width: 40.0.sp),
              ],
            ),
          ),
          extendWidget ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
