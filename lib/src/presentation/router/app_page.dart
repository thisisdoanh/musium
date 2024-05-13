import 'package:get/get.dart';
import 'package:musinum/src/presentation/screen/album/album_binding.dart';
import 'package:musinum/src/presentation/screen/main/main_binding.dart';
import 'package:musinum/src/presentation/screen/main/main_screen.dart';
import 'package:musinum/src/presentation/screen/playlist/playlist_binding.dart';
import 'package:musinum/src/presentation/screen/playlist/playlist_screen.dart';
import 'package:musinum/src/presentation/screen/track/track_binding.dart';
import 'package:musinum/src/presentation/screen/track/track_screen.dart';

import '../screen/album/album_screen.dart';
import '../screen/intro/intro_binding.dart';
import '../screen/intro/intro_screen.dart';
import '../screen/search/search_binding.dart';
import '../screen/search/search_screen.dart';
import '../screen/splash/splash_binding.dart';
import '../screen/splash/splash_screen.dart';
import 'app_router.dart';

class AppPage {
  static final pages = [
    GetPage(
      name: AppRouter.splashScreen,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRouter.introScreen,
      page: () => const IntroScreen(),
      binding: IntroBinding(),
    ),
    GetPage(
      name: AppRouter.homeScreen,
      page: () => const MainScreen(),
      binding: MainBinding(),
    ),
    GetPage(
      name: AppRouter.searchScreen,
      page: () => const SearchScreen(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: AppRouter.playlistScreen,
      page: () => const PlaylistScreen(),
      binding: PlayListBinding(),
    ),
    GetPage(
      name: AppRouter.albumScreen,
      page: () => const AlbumScreen(),
      binding: AlbumBinding(),
    ),
    GetPage(
      name: AppRouter.trackScreen,
      page: () => const TrackScreen(),
      binding: TrackBinding(),
    ),
  ];
}
