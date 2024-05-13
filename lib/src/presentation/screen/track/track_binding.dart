import 'package:get/get.dart';
import 'package:musinum/src/presentation/screen/track/track_controller.dart';

class TrackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrackController());
  }
}
