import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:musinum/src/data/model/lyric_model.dart';
import 'package:spotify/spotify.dart';

import 'app_color.dart';

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

showToast(String text, {bool isLong = true}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
    backgroundColor: AppColor.black.withOpacity(0.9),
    textColor: AppColor.white,
    fontSize: 16.sp,
  );
}

List<LyricModel> lyricProcessing(String raw) {
  List<String> listRaw = raw.split("\n");
  List<LyricModel> listLyric = [];
  for (int i = 0; i < listRaw.length; i++) {
    List<String> itemList = listRaw[i].split("]");
    DateTime timeStamp = DateFormat("mm:ss.SS").parse(itemList[0].substring(1));
    String lyric = "";
    for (int j = 1; j < itemList.length; j++) {
      lyric += itemList[j];
    }
    listLyric.add(LyricModel(words: lyric, timeStamp: timeStamp));
  }
  return listLyric;
}
