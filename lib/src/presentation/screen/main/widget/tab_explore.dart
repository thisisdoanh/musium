import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:musinum/src/presentation/router/app_router.dart';
import 'package:musinum/src/presentation/screen/main/main_controller.dart';
import 'package:musinum/src/presentation/widget/app_image_widget.dart';
import 'package:musinum/src/res/string/string_constants.dart';
import 'package:spotify/spotify.dart';

import '../../../../res/image/app_image.dart';
import '../../../../util/app_color.dart';
import '../../../widget/disable_glow_bahavior.dart';

class TabExplore extends GetWidget<MainController> {
  const TabExplore({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: ScrollConfiguration(
        behavior: DisableGlowBehavior(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(Get.mediaQuery.padding.top + 12.sp),
              Row(
                children: [
                  AppImageWidget.asset(
                    path: AppImage.imgLogo,
                    height: 45.sp,
                  ),
                  Text(
                    StringConstants.search.tr,
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.75,
                    ),
                  )
                ],
              ),
              Gap(24.sp),
              TextFormField(
                maxLines: 1,
                readOnly: true,
                onTap: () {
                  Get.toNamed(AppRouter.searchScreen);
                },
                style: const TextStyle(
                    color: AppColor.gray,
                    fontFamily: "Mulish",
                    fontWeight: FontWeight.w600),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColor.transparent,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(60.0.sp),
                    ),
                  ),
                  fillColor: AppColor.white,
                  filled: true,
                  enabledBorder: null,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColor.transparent,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(60.0.sp),
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.sp,
                    vertical: 8.sp,
                  ),
                  hintText: StringConstants.hintSearch.tr,
                  hintStyle:
                      TextStyle(color: AppColor.greyA9D, fontSize: 16.0.sp),
                ),
              ),
              Gap(24.sp),
              Text(
                StringConstants.yourTopArtist.tr,
                style: TextStyle(
                  color: AppColor.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.sp,
                    mainAxisSpacing: 20.sp,
                    mainAxisExtent: 120.sp),
                itemBuilder: (context, index) {
                  Artist artist = controller.listTopArtist[index];
                  return Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(
                        Random().nextInt(150) + 50,
                        Random().nextInt(150) + 50,
                        Random().nextInt(150) + 50,
                        1,
                      ),
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                    child: Stack(
                      fit: StackFit.loose,
                      children: [
                        Positioned(
                          bottom: -10.sp,
                          right: -10.sp,
                          child: Transform.rotate(
                            angle: pi / 6,
                            child: artist.images?.first.url != null
                                ? AppImageWidget.network(
                                    path: artist.images?.first.url ?? "",
                                    height: Get.width * 0.23,
                                    width: Get.width * 0.23,
                                    fit: BoxFit.contain,
                                  )
                                : Container(
                                    height: 60.sp,
                                    width: 60.sp,
                                    alignment: Alignment.center,
                                    child: AppImageWidget.asset(
                                      path: AppImage.imgLogo,
                                      height: 40.sp,
                                      width: 40.sp,
                                    ),
                                  ),
                          ),
                        ),
                        Positioned(
                          top: 12.sp,
                          left: 12.sp,
                          child: SizedBox(
                            width: Get.width * 0.5 - 16.sp - 10.sp - 24.sp,
                            child: Text(
                              "${artist.name}",
                              style: TextStyle(
                                color: AppColor.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: controller.listTopArtist.length,
                shrinkWrap: true,
                primary: false,
              ),
              Gap(30.sp),
            ],
          ),
        ),
      ),
    );
  }
}
