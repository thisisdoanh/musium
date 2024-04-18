class ApiConstant {
  static const CONNECT_TIME_OUT = Duration(seconds: 30);
  static const RECEIVE_TIME_OUT = Duration(seconds: 30);

  static const RAPID_KEY = "f7a518daf4msh3c184e00980affap197ee7jsn44dfe3ac6589";
  static const RAPID_HOST = "spotify23.p.rapidapi.com";

  static const CLIENT_ID ="bb5486b1255649f1a2b107e82d0c99ba";
  static const CLIENT_SECRET ="8d73d0dc203248939408bf4710fa85f6";

  static String ACCESS_TOKEN = "";
  static String REFRESH_TOKEN ="";

  ///End point
  static const urlSearch = "https://spotify23.p.rapidapi.com/search";
  static const urlArtist = "https://spotify23.p.rapidapi.com/artists";
  static const urlAlbum = "https://spotify23.p.rapidapi.com/albums/";
}
