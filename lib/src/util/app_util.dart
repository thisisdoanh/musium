import 'package:spotify/spotify.dart';

String getArtistName(List<dynamic> artists) {
  if (artists.first is Artist || artists.first is ArtistSimple) {
    String name = "";
    for (int i = 0; i < artists.length; i++) {
      name += artists[i].name ?? "";
      name += ",";
    }
    return name.substring(0, name.length - 1);
  }
  return "";
}
