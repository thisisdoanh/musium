import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:musinum/src/data/service/api_service.dart';
import 'package:musinum/src/util/app_log.dart';
import 'package:musinum/src/util/app_util.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:spotify/spotify.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../../data/model/lyric_model.dart';

class TrackController extends GetxController {
  Rx<Track> track = Track().obs;

  RxList<LyricModel> lyric = <LyricModel>[].obs;

  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();
  StreamSubscription? streamSubscription;

  final youtube = YoutubeExplode();
  final audioPlayer = AudioPlayer();
  Duration? duration;

  @override
  void onInit() async {
    track.value = Get.arguments["track"];
    if (track.value.name != null) {
      final youtubeResult = (await youtube.search.search(
              "${track.value.name} ${getArtistName(track.value.artists ?? [])}"))
          .first;
      final id = youtubeResult.id.value;
      var manifest = await youtube.videos.streamsClient.getManifest(id);
      var audioUrl = manifest.audioOnly.first.url;
      duration = youtubeResult.duration;
      AppLog.info(duration);
      audioPlayer.setSource(UrlSource(audioUrl.toString()));
    } else {
      showToast("text");
    }

    super.onInit();
  }

  @override
  void onReady() async {
    lyric.value = await ApiService.getLyric(
        songName: track.value.name ?? "",
        artist: getArtistName(track.value.artists ?? []));
    audioPlayer.seek(Duration.zero);
    audioPlayer.resume();

    streamSubscription = audioPlayer.onPositionChanged.listen((event) {
      DateTime time = DateTime(1970,1,1).copyWith(
        hour: event.inHours,
        minute: event.inMinutes,
        second: event.inSeconds,
      );
      if(lyric != []) {
        for (int index = 0; index < lyric.length; index++) {
          if (index > 4 && lyric[index].timeStamp!.isAfter(time)) {
            itemScrollController.scrollTo(
                index: index - 3, duration: const Duration(milliseconds: 600));
            break;
          }
        }
      }
    });
    super.onReady();
  }
}
