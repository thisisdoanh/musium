import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:musinum/src/presentation/router/app_router.dart';
import 'package:musinum/src/presentation/widget/app_container.dart';
import 'package:musinum/src/presentation/widget/app_image_widget.dart';
import 'package:musinum/src/presentation/widget/app_touchable.dart';
import 'package:musinum/src/res/image/app_image.dart';
import 'package:spotify/spotify.dart';

import '../../../res/string/string_constants.dart';
import '../../../util/app_color.dart';
import 'search_controller.dart' as search;

class SearchScreen extends GetView<search.SearchController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      resizeToAvoidBottomInset: true,
      child: Column(
        children: [
          Gap(Get.mediaQuery.padding.top),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.sp,
              vertical: 6.sp,
            ),
            decoration: const BoxDecoration(color: AppColor.gray),
            child: Row(
              children: [
                AppTouchable(
                  onPressed: Get.back,
                  child: AppImageWidget.asset(
                    path: AppImage.icBack,
                  ),
                ),
                Gap(16.sp),
                Expanded(
                  child: TextFormField(
                    maxLines: 1,
                    autofocus: true,
                    controller: controller.controllerSearch,
                    onChanged: controller.onChangeSearch,
                    onFieldSubmitted: controller.onChangeSearch,
                    style: const TextStyle(
                      color: AppColor.white,
                      fontFamily: "Mulish",
                      fontWeight: FontWeight.w600,
                    ),
                    cursorColor: AppColor.white,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: StringConstants.hintSearch.tr,
                      hintStyle:
                          TextStyle(color: AppColor.greyA9D, fontSize: 16.0.sp),
                      suffixIcon: AppTouchable(
                        onPressed: () {
                          controller.controllerSearch.clear();
                          controller.onChangeSearch("");
                        },
                        child: AppImageWidget.asset(path: AppImage.icDelete),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => controller.listSearch.isEmpty
                ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StringConstants.contentSearch1.tr,
                          style: TextStyle(
                            color: AppColor.white,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gap(8.sp),
                        Text(
                          StringConstants.contentSearch2.tr,
                          style: TextStyle(
                            color: AppColor.gray,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  )
                : Obx(
                    () => Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.sp,
                          vertical: 12.sp,
                        ),
                        itemBuilder: (context, index) {
                          try {
                            var items =
                                (controller.listSearch[index].items ?? [])
                                    .toList();
                            if (items.isNotEmpty) {
                              if (items.isNotEmpty &&
                                  items.first is AlbumSimple) {
                                return Column(
                                  children: items.map(
                                    (e) {
                                      AlbumSimple item = e as AlbumSimple;
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8.sp),
                                        child: AppTouchable(
                                          onPressed: () => Get.toNamed(
                                              AppRouter.albumScreen,
                                              arguments: {
                                                "album": item,
                                              }),
                                          child: Row(
                                            children: [
                                              item.images?.first.url != null
                                                  ? AppImageWidget.network(
                                                      path: item.images?.first
                                                              .url ??
                                                          "",
                                                      height: 60.sp,
                                                      width: 60.sp,
                                                    )
                                                  : Container(
                                                      height: 60.sp,
                                                      width: 60.sp,
                                                      alignment:
                                                          Alignment.center,
                                                      child:
                                                          AppImageWidget.asset(
                                                        path: AppImage.imgLogo,
                                                        height: 40.sp,
                                                        width: 40.sp,
                                                      ),
                                                    ),
                                              Gap(12.sp),
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item.name ?? "",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: AppColor.white,
                                                        fontFamily: "Mulish",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14.sp,
                                                      ),
                                                    ),
                                                    Gap(4.sp),
                                                    Text(
                                                      "${StringConstants.album.tr} • ${controller.getArtistName(item.artists!)}",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: AppColor.gray,
                                                        fontFamily: "Mulish",
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                        ),
                                      );
                                    },
                                  ).toList(),
                                );
                              }
                              if (items.isNotEmpty && items.first is Track) {
                                return Column(
                                  children: items.map(
                                    (e) {
                                      Track item = e as Track;
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8.sp),
                                        child: Row(
                                          children: [
                                            item.album?.images?.first.url !=
                                                    null
                                                ? AppImageWidget.network(
                                                    path: item.album?.images
                                                            ?.first.url ??
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
                                            Gap(12.sp),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.name ?? "",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: AppColor.white,
                                                      fontFamily: "Mulish",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                  Gap(4.sp),
                                                  Text(
                                                    "${StringConstants.song.tr} • ${controller.getArtistName(item.artists!)}",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: AppColor.gray,
                                                      fontFamily: "Mulish",
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                  ).toList(),
                                );
                              }
                              if (items.isNotEmpty &&
                                  items.first is PlaylistSimple) {
                                return Column(
                                  children: items.map(
                                    (e) {
                                      PlaylistSimple item = e as PlaylistSimple;
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8.sp),
                                        child: AppTouchable(
                                          onPressed: () => Get.toNamed(
                                              AppRouter.playlistScreen,
                                              arguments: {
                                                "playlist": item,
                                              }),
                                          child: Row(
                                            children: [
                                              item.images?.first.url != null
                                                  ? AppImageWidget.network(
                                                      path: item.images?.first
                                                              .url ??
                                                          "",
                                                      height: 60.sp,
                                                      width: 60.sp,
                                                    )
                                                  : Container(
                                                      height: 60.sp,
                                                      width: 60.sp,
                                                      alignment:
                                                          Alignment.center,
                                                      child:
                                                          AppImageWidget.asset(
                                                        path: AppImage.imgLogo,
                                                        height: 40.sp,
                                                        width: 40.sp,
                                                      ),
                                                    ),
                                              Gap(12.sp),
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item.name ?? "",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: AppColor.white,
                                                        fontFamily: "Mulish",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14.sp,
                                                      ),
                                                    ),
                                                    Gap(4.sp),
                                                    Text(
                                                      "${StringConstants.playlist.tr} • ${item.owner?.displayName}",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: AppColor.gray,
                                                        fontFamily: "Mulish",
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                        ),
                                      );
                                    },
                                  ).toList(),
                                );
                              }
                              if (items.isNotEmpty && items.first is Artist) {
                                return Column(
                                  children: items.map(
                                    (e) {
                                      Artist item = e as Artist;
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8.sp),
                                        child: Row(
                                          children: [
                                            item.images?.first.url != null
                                                ? AppImageWidget.network(
                                                    path: item.images?.first
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
                                            Gap(12.sp),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.name ?? "",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: AppColor.white,
                                                      fontFamily: "Mulish",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                  Gap(4.sp),
                                                  Text(
                                                    "${StringConstants.artist.tr} • ${item.name}",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: AppColor.gray,
                                                      fontFamily: "Mulish",
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                  ).toList(),
                                );
                              }
                            }
                          } catch (e) {
                            return const SizedBox.shrink();
                          }

                          return const SizedBox.shrink();
                        },
                        itemCount: min(4, controller.listSearch.length),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
