import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:musinum/src/presentation/router/app_router.dart';
import 'package:musinum/src/presentation/widget/app_image_widget.dart';
import 'package:musinum/src/presentation/widget/app_touchable.dart';
import 'package:musinum/src/presentation/widget/disable_glow_bahavior.dart';
import 'package:musinum/src/res/image/app_image.dart';
import 'package:spotify/spotify.dart';

import '../../../../data/service/api_service.dart';
import '../../../../res/string/string_constants.dart';
import '../../../../util/app_color.dart';
import '../main_controller.dart';

class TabHome extends GetWidget<MainController> {
  const TabHome({super.key});

  Widget _buildTitle({required String title}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: Text(
        title,
        style: TextStyle(
          color: AppColor.white,
          fontSize: 22.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
    controller.isLoading.value
        ? Container(
      height: 50.sp,
      width: 50.sp,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        color: AppColor.primaryColor,
      ),
    )
        : ScrollConfiguration(
      behavior: DisableGlowBehavior(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(Get.mediaQuery.padding.top + 12.sp),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.blue1B7,
                    ),
                    padding: EdgeInsets.all(8.sp),
                    alignment: Alignment.center,
                    child: AppImageWidget.asset(
                      path: AppImage.imgUser,
                      height: 40.sp,
                      width: 40.sp,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Gap(16.sp),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        StringConstants.welcomeBack.tr,
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        StringConstants.guest.tr,
                        style: TextStyle(
                          color: AppColor.white.withOpacity(0.6.sp),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.36,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  AppTouchable(
                    onPressed: () async {
                      await ApiService.getTopGenres();
                    },
                    child: AppImageWidget.asset(
                      path: AppImage.icRank,
                      width: 30.sp,
                      height: 30.sp,
                    ),
                  ),
                  Gap(12.sp),
                  AppImageWidget.asset(
                    path: AppImage.icBell,
                    width: 22.sp,
                    height: 22.sp,
                  ),
                  Gap(12.sp),
                  AppImageWidget.asset(
                    path: AppImage.icSetting,
                    width: 22.sp,
                    height: 22.sp,
                  ),
                ],
              ),
            ),
            Gap(40.sp),
            _buildTitle(title: StringConstants.continueListening.tr),
            Gap(40.sp),
            _buildTitle(title: StringConstants.yourTopMixes.tr),
            Gap(12.sp),
            SizedBox(
              height: 205.sp,
              width: Get.width,
              child: Obx(
                    () =>
                controller.listTrackResponse.isEmpty
                    ? Container(
                    height: 40.sp,
                    width: 40.sp,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator())
                    : ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16.sp),
                  itemBuilder: (context, index) {
                    Track track =
                    controller.listTrackResponse[index];
                    String artistName = controller
                        .getArtistName(track.artists ?? []);
                    return Container(
                      width: 170.sp,
                      padding: index == controller.listTrackResponse.length - 1
                          ? null
                          : EdgeInsets.only(
                        right: 20.sp,
                      ),
                      child: AppTouchable(
                        onPressed: () =>
                            Get.toNamed(AppRouter.trackScreen, arguments: {
                            "track": track,
                            }),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            track.album?.images?.first.url != null
                                ? AppImageWidget.network(
                              path: track.album?.images?.first
                                  .url ??
                                  "",
                              height: 150.sp,
                              width: 150.sp,
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
                            Gap(8.sp),
                            Text(
                              track.name ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColor.white,
                                fontFamily: "Mulish",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Gap(4.sp),
                            Text(
                              artistName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColor.greyA9D,
                                fontFamily: "Mulish",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Gap(40.sp),
            _buildTitle(title: StringConstants.baseOnYourRecent.tr),
            Obx(
                  () =>
              controller.listTrackResponse.isEmpty
                  ? const SizedBox(child: CircularProgressIndicator())
                  : GridView.builder(
                itemCount: 10,
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.symmetric(
                    horizontal: 16.sp, vertical: 10.sp),
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 210.sp,
                  crossAxisSpacing: 20.sp,
                  mainAxisSpacing: 16.sp,
                ),
                itemBuilder: (context, index) {
                  index += 10;
                  Track track = controller.listTrackResponse[index];
                  String artistName =
                  controller.getArtistName(track.artists ?? []);
                  return SizedBox(
                    width: 150.sp,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        track.album?.images?.first.url != null
                            ? AppImageWidget.network(
                          path: track
                              .album?.images?.first.url ??
                              "",
                          height: 150.sp,
                          width: 150.sp,
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
                        Gap(8.sp),
                        Text(
                          track.name ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColor.white,
                            fontFamily: "Mulish",
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Gap(4.sp),
                        Text(
                          artistName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColor.greyA9D,
                            fontFamily: "Mulish",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
