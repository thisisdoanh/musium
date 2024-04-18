import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/spotify.dart' as spotify;

import '../../../data/model/app_response.dart';
import '../../../data/service/api_service.dart';
import '../../../data/store/hive_data_store.dart';
import '../../../util/app_log.dart';

class SearchController extends GetxController {
  late BuildContext context;
  RxList<AppResponse> listHistorySearch = <AppResponse>[].obs;
  RxList<spotify.Page<dynamic>> listSearch = <spotify.Page>[].obs;

  TextEditingController controllerSearch = TextEditingController();

  @override
  void onClose() {
    controllerSearch.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  initData() async {
    listHistorySearch.value = await HiveDataStore.getAllHistoryListen();
  }

  Future<void> onChangeSearch(String text) async {
    if (text.isEmpty) {
      controllerSearch.clear();
      listSearch.value = [];
      return;
    }
    listSearch.value = (await ApiService.getSearch(text))!;
  }

  String getArtistName(List<spotify.ArtistSimple> artists) {
    String name = "";
    for (int i = 0; i < artists.length; i++) {
      name += artists[i].name ?? "";
      name += ",";
    }
    return name.substring(0, name.length - 1);
  }

  Future<void> insertToBox({required dynamic data, required Type type}) async {
    int indexInsert = await HiveDataStore.addHistoryListen(
      item: AppResponse(data: data, type: type),
    );
    AppLog.info(indexInsert, tag: "insertToBox");
  }
}
