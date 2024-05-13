import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musinum/src/presentation/screen/track/track_controller.dart';
import 'package:musinum/src/presentation/widget/app_container.dart';
import 'package:musinum/src/presentation/widget/app_header.dart';
import 'package:musinum/src/presentation/widget/app_image_widget.dart';
import 'package:musinum/src/presentation/widget/app_touchable.dart';
import 'package:musinum/src/res/image/app_image.dart';
import 'package:musinum/src/res/string/string_constants.dart';
import 'package:musinum/src/util/app_color.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TrackScreen extends GetView<TrackController> {
  const TrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        children: [
          AppHeader(
            title: StringConstants.song.tr,
            titleStyle: TextStyle(
              fontSize: 20.sp,
            ),
            rightWidget: AppTouchable(
              onPressed: () {},
              child: AppImageWidget.asset(
                path: AppImage.icMenu,
              ),
            ),
          ),
          AppImageWidget.network(
            path: controller.track.value.album?.images?.first.url ?? "",
            width: Get.width * 0.9,
            height: Get.width * 0.9,
            fit: BoxFit.cover,
          ),
          Expanded(
              child: StreamBuilder<Duration>(
            stream: controller.audioPlayer.onPositionChanged,
            builder: (BuildContext context, AsyncSnapshot<Duration> snapshot) {
              Duration duration = snapshot.data ?? const Duration(seconds: 0);
              DateTime dt = DateTime(1970, 1, 1).copyWith(
                  hour: duration.inHours,
                  minute: duration.inMinutes.remainder(60),
                  second: duration.inSeconds.remainder(60));
              return Obx(
                () => controller.lyric.isNotEmpty
                    ? ScrollablePositionedList.builder(
                        itemBuilder: (context, index) => Text(
                          controller.lyric[index].words.toString(),
                          style: TextStyle(
                              color:
                                  controller.lyric[index].timeStamp!.isAfter(dt)
                                      ? AppColor.white
                                      : AppColor.gray,
                              fontFamily: "Mulish",
                              fontSize: 20.sp),
                        ),
                        itemCount: controller.lyric.length,
                        shrinkWrap: true,
                        itemScrollController: controller.itemScrollController,
                        scrollOffsetController:
                            controller.scrollOffsetController,
                        itemPositionsListener: controller.itemPositionsListener,
                        scrollOffsetListener: controller.scrollOffsetListener,
                      )
                    : SizedBox.shrink(),
              );
            },
          )),
        ],
      ),
    );
  }
}
