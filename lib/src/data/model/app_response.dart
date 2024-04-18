import 'package:hive_flutter/hive_flutter.dart';

part 'app_response.g.dart';

@HiveType(typeId: 0)
class AppResponse extends HiveObject {
  @HiveField(0)
  final dynamic data;

  @HiveField(1)
  final Type type;

  AppResponse({
    required this.data,
    required this.type,
  });
}

enum Type { album, playlist, track, artist, podcast }
