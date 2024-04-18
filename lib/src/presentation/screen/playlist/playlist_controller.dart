import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:musinum/src/data/service/api_service.dart';
import 'package:spotify/spotify.dart';

class PlaylistController extends GetxController {
  Rx<PlaylistSimple> playlistInfo = PlaylistSimple().obs;

  RxList<Track> playlistTracks = <Track>[].obs;

  RxBool isLoading = false.obs;

  final player = AudioPlayer();

  @override
  void onInit() {
    playlistInfo.value = Get.arguments["playlist"];
    super.onInit();
  }

  @override
  void onReady() async {
    isLoading.value = true;
    playlistTracks.value = await ApiService.getTrackFromPlaylist(
            playlistId: playlistInfo.value.id ?? "") ??
        [];
    isLoading.value = false;

    super.onReady();
  }

}
