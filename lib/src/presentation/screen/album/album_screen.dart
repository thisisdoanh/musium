import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:musinum/src/presentation/screen/album/album_controller.dart';
import 'package:musinum/src/presentation/widget/app_container.dart';
import 'package:musinum/src/presentation/widget/app_image_widget.dart';
import 'package:musinum/src/presentation/widget/disable_glow_bahavior.dart';
import 'package:musinum/src/res/string/string_constants.dart';
import 'package:musinum/src/util/app_util.dart';

import '../../../res/image/app_image.dart';
import '../../../util/app_color.dart';
import '../../widget/app_header.dart';

class AlbumScreen extends GetView<AlbumController> {
  const AlbumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        children: [
          AppHeader(
            title:
                "${StringConstants.from.tr} \"${controller.albumInfo.value.name}\"",
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: DisableGlowBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Gap(10.sp),
                    AppImageWidget.network(
                      path: "${controller.albumInfo.value.images?.first.url}",
                      height: Get.width * 0.6,
                      width: Get.width * 0.6,
                    ),
                    Gap(12.sp),
                    Text(
                      controller.albumInfo.value.name ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28.sp,
                        color: AppColor.white,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.72,
                      ),
                    ),
                    Gap(4.sp),
                    Text(
                      getArtistName(controller.albumInfo.value.artists ?? []),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColor.white,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.72,
                      ),
                    ),
                    Gap(20.sp),
                    Obx(
                      () => controller.isLoading.value
                          ? Container(
                              height: 50.sp,
                              width: 50.sp,
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(
                                color: AppColor.primaryColor,
                              ),
                            )
                          : ListView.builder(
                              itemCount: controller.albumTracks.length,
                              shrinkWrap: true,
                              primary: false,
                              padding: EdgeInsets.symmetric(
                                vertical: 10.sp,
                                horizontal: 16.sp,
                              ),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 8.0.sp),
                                  child: Row(
                                    children: [
                                      Obx(
                                        () => controller
                                                    .albumTracks[index]
                                                    .artists
                                                    ?.first
                                                    .images
                                                    ?.first
                                                    .url !=
                                                null
                                            ? AppImageWidget.network(
                                                path: controller
                                                        .albumTracks[index]
                                                        .artists
                                                        ?.first
                                                        .images
                                                        ?.first
                                                        .url ??
                                                    "",
                                                height: 60.sp,
                                                width: 60.sp,
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
                                      Gap(12.sp),
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.albumTracks[index]
                                                      .name ??
                                                  "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: AppColor.white,
                                                fontFamily: "Mulish",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                            Gap(4.sp),
                                            Text(
                                              getArtistName(controller
                                                      .albumTracks[index]
                                                      .artists ??
                                                  []),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: AppColor.gray,
                                                fontFamily: "Mulish",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Gap(12.sp),
                                      AppImageWidget.asset(
                                          path: AppImage.icMenu),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
