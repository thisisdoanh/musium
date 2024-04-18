import 'package:get/get.dart';
import 'package:musinum/src/data/model/app_response.dart';
import 'package:musinum/src/data/service/api_service.dart';
import 'package:spotify/spotify.dart' as spotify;

class MainController extends GetxController {
  RxInt currentTabIndex = 0.obs;
  RxList<spotify.Track> listTrackResponse = <spotify.Track>[].obs;
  RxList<AppResponse> listHistoryListen = <AppResponse>[].obs;
  RxList<spotify.Artist> listTopArtist = <spotify.Artist>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    isLoading.value = true;
    await initData();
    isLoading.value = false;
    super.onInit();
  }

  Future<void> initData() async {
    listTrackResponse.value = await ApiService.getTopTracks() ?? [];
    listTopArtist.value = await ApiService.getTopGenres() ?? [];
  }

  String getArtistName(List<spotify.Artist> artists) {
    String name = "";
    for (int i = 0; i < artists.length; i++) {
      name += artists[i].name ?? "";
      name += ",";
    }
    return name.substring(0, name.length - 1);
  }
}
