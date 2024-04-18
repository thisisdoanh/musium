import 'package:get/get.dart';
import 'package:musinum/src/data/service/api_service.dart';
import 'package:musinum/src/util/app_log.dart';
import 'package:spotify/spotify.dart';

class AlbumController extends GetxController {
  Rx<AlbumSimple> albumInfo = AlbumSimple().obs;

  RxList<TrackSimple> albumTracks = <TrackSimple>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    albumInfo.value = Get.arguments["album"];

    super.onInit();
  }

  @override
  void onReady() async {
    isLoading.value = true;
    albumTracks.value =
        await ApiService.getTrackFromAlbum(albumId: albumInfo.value.id ?? "") ??
            [];
    AppLog.info(albumTracks.length);
    isLoading.value = false;
    super.onReady();
  }
}
