import 'package:get/get.dart';

import 'album_controller.dart';

class AlbumBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AlbumController());
  }
}
