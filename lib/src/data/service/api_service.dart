import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:musinum/src/data/model/base_response.dart';
import 'package:musinum/src/data/model/lyric_model.dart';
import 'package:musinum/src/data/provider/api_client.dart';
import 'package:musinum/src/data/provider/api_constant.dart';
import 'package:musinum/src/res/string/string_constants.dart';
import 'package:musinum/src/util/app_log.dart';
import 'package:musinum/src/util/app_util.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/spotify_oauth2_client.dart';
import 'package:spotify/spotify.dart';

class ApiService {
  ApiService._();

  static List<String> listIDAlbum = [
    "12ru2jUVb2fVyZJhFREk2z",
    "6sSzX4hOaL72r5S1SGARXr",
    "3YTsTxFi7qKmDx2TqlpYKG",
    "1hQTPI2yI4vpow1IJ60aOf",
    "2kAfjyt7PAYXhvgO0FnPXq",
    "06ChHqsqctnya324GPfxGQ",
    "13U69iqaX0siQ443YDfFuH",
    "50NPIj1xRw3Yj20SLuobE8",
    "3UXiqsW19lxn25YLVQ9pmO",
    "1vi1WySkgPGkbR8NnQzlXu",
    "1c4nTHI2hreFeF5P37wf4f",
    "7daUoULVORfrXVg0kTAhBc",
    "7v4sqd0NZ9Fm8HnwCcCGIs",
    "0LM9Cm43Sug8Hfpm84qmt6",
    "4faMbTZifuYsBllYHZsFKJ",
    "52MYcZ4Hzvy9vJcPicjfHZ",
    "5EYKrEDnKhhcNxGedaRQeK",
    "5NODJ4FZWvaLLiFd554kLI",
    "1vi1WySkgPGkbR8NnQzlXu",
    "5pSk3c3wVwnb2arb6ohCPU",
    "10qvBn2MB8C4qGdj2aSymU",
  ];
  static final credentials =
      SpotifyApiCredentials(ApiConstant.CLIENT_ID, ApiConstant.CLIENT_SECRET);
  static SpotifyApi? spotify;

  static Future<void> getAuthentication() async {
    AccessTokenResponse? accessToken;
    SpotifyOAuth2Client client = SpotifyOAuth2Client(
      customUriScheme: 'my.music.app',
      //Must correspond to the AndroidManifest's "android:scheme" attribute
      redirectUri:
          'my.music.app://callback', //Can be any URI, but the scheme part must correspond to the customeUriScheme
    );
    var authResp = await client.requestAuthorization(
        clientId: ApiConstant.CLIENT_ID,
        customParams: {'show_dialog': 'true'},
        scopes: [...AuthorizationScope.all]);

    AppLog.info(
        "error:${authResp.error}\ncode:${authResp.code}\nerrorDescription:${authResp.errorDescription}\nqueryParams:${authResp.queryParams}\n${authResp.isAccessGranted()}");

    if (authResp.isAccessGranted()) {
      var authCode = authResp.code;

      accessToken = await client.requestAccessToken(
        code: authCode.toString(),
        clientId: ApiConstant.CLIENT_ID,
        clientSecret: ApiConstant.CLIENT_SECRET,
      );

      ApiConstant.ACCESS_TOKEN = accessToken.accessToken ?? "";
      ApiConstant.REFRESH_TOKEN = accessToken.refreshToken ?? "";
      AppLog.info(
          "ACCESS_TOKEN: ${ApiConstant.ACCESS_TOKEN}\nREFRESH_TOKEN: ${ApiConstant.REFRESH_TOKEN}");
      if (ApiConstant.ACCESS_TOKEN == "") {
        spotify = SpotifyApi(credentials);
      } else {
        spotify = SpotifyApi.withAccessToken(ApiConstant.ACCESS_TOKEN);
      }
    } else {
      showToast(StringConstants.mustAcceptAuth.tr);
      AppLog.info(StringConstants.mustAcceptAuth.tr);
    }
  }

  static Future<Iterable<Album>?> getAlbums(
      {List<String>? listID, int? length}) async {
    listIDAlbum.shuffle();
    listID = listID ?? listIDAlbum.toSet().take(length ?? 1).toList();
    final listAlbum = await spotify?.albums.list(listID);
    return listAlbum;
  }

  static Future<List<Track>?> getTopTracks({int? page}) async {
    final response = (await spotify?.me
            .topTracks(timeRange: TimeRange.longTerm)
            .getPage(20, page ?? 0))
        ?.items
        ?.toList();
    return response;
  }

  static Future<List<Artist>?> getTopGenres({int? page}) async {
    final response = (await spotify?.me
            .topArtists(timeRange: TimeRange.longTerm)
            .getPage(20, page ?? 0))
        ?.items
        ?.toList();
    return response;
  }

  static Future<List<Page<dynamic>>?> getSearch(String text) async {
    final response = await spotify?.search.get(text).first(4);

    return response;
  }

  static Future<List<Track>?> getTrackFromPlaylist(
      {required String playlistId}) async {
    final response =
        (await spotify?.playlists.getTracksByPlaylistId(playlistId).all())
            ?.toList();
    return response;
  }

  static Future<List<TrackSimple>?> getTrackFromAlbum(
      {required String albumId}) async {
    final response = (await spotify?.albums.tracks(albumId).all())?.toList();

    return response;
  }

  static Future<List<LyricModel>> getLyric(
      {required String songName, required String artist}) async {
    BaseResponse response = await ApiClient(
      options: BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        responseType: ResponseType.plain,
        headers: {
          'Cache-Control': 'no-cache',
          'Content-Type': 'text/html; charset=UTF-8'
          // "X-RapidAPI-Key": "f7a518daf4msh3c184e00980affap197ee7jsn44dfe3ac6589",
          // "X-RapidAPI-Host": "spotify23.p.rapidapi.com",
        },
      ),
    ).request(
      endPoint: "https://paxsenixofc.my.id/server/getLyricsMusix.php",
      method: ApiClient.GET,
      queryParameters: {
        "q": "$songName $artist",
        "type": "default",
      },
      isJson: false,
    );
    if (response.result == true &&
        (response.data as String).isNotEmpty &&
        !(response.data as String).contains("Fatal error")) {
      AppLog.info(response.data);
      return lyricProcessing(response.data);
    } else {
      AppLog.info("Not found lyrics");
      return [];
    }
  }
}
