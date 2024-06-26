import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:musinum/src/presentation/screen/playlist/playlist_controller.dart';
import 'package:musinum/src/presentation/widget/app_container.dart';

import '../../../res/image/app_image.dart';
import '../../../res/string/string_constants.dart';
import '../../../util/app_color.dart';
import '../../../util/app_util.dart';
import '../../widget/app_image_widget.dart';
import '../../widget/app_touchable.dart';

class PlaylistScreen extends GetView<PlaylistController> {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: CustomScrollView(
        controller: controller.scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: Get.width * 0.6 + 45.sp,
            pinned: true,
            backgroundColor: AppColor.backgroundColor,
            excludeHeaderSemantics: true,
            leading: AppTouchable(
              onPressed: Get.back,
              child: AppImageWidget.asset(
                path: AppImage.icBack,
              ),
            ),
            title: Text(
              "${StringConstants.from.tr} \"${controller.playlistInfo.value.name}\"",
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColor.white,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.72,
              ),
            ),
            centerTitle: true,
            actions: [
             SizedBox(height: 40.sp,width: 40.sp,),
            ],
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.blurBackground],
              collapseMode: CollapseMode.parallax,
              background: Column(
                children: [
                  AppImageWidget.network(
                    path: "${controller.playlistInfo.value.images?.first.url}",
                    height: Get.width * 0.6,
                    width: Get.width * 0.6,
                  ),
                  Gap(12.sp),
                  Text(
                    controller.playlistInfo.value.name ?? "",
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
                    controller.playlistInfo.value.owner?.displayName ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColor.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.72,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
              delegate:
                  SliverChildBuilderDelegate(childCount: 1, (context, index) {
            return Obx(() => controller.isLoading.value
                ? Container(
                    height: 50.sp,
                    width: 50.sp,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      color: AppColor.primaryColor,
                    ),
                  )
                : Column(
                    children: [
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
                                itemCount: controller.playlistTracks.length,
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
                                                      .playlistTracks[index]
                                                      .album
                                                      ?.images
                                                      ?.first
                                                      .url !=
                                                  null
                                              ? AppImageWidget.network(
                                                  path: controller
                                                          .playlistTracks[index]
                                                          .album
                                                          ?.images
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
                                                controller.playlistTracks[index]
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
                                                        .playlistTracks[index]
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
                  ));
          }))
        ],
      ),
    );
  }
}
