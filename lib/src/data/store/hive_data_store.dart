import 'package:hive/hive.dart';
import 'package:musinum/src/data/model/app_response.dart';

class HiveDataStore {
  HiveDataStore._();

  static const historyListenBoxName = "history_listen_box";
  static final Box<AppResponse> historyListenBox =
      Hive.box<AppResponse>(historyListenBoxName);

  static Future<int> addHistoryListen({required AppResponse item}) async {
    return await historyListenBox.add(item);
  }

  static Future<List<AppResponse>> getAllHistoryListen() async {
    return historyListenBox.values.toList();
  }
}
