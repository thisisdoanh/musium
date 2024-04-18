import 'package:get/get.dart';
import 'package:musinum/src/presentation/screen/playlist/playlist_controller.dart';

class PlayListBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => PlaylistController());
  }
}