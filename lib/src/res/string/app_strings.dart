import 'package:get/get.dart';

import 'en_string.dart';

class AppStrings extends Translations {
  static const String localeCodeEn = 'en_US';

  @override
  Map<String, Map<String, String>> get keys => {
        localeCodeEn: enStrings,
      };

  static String getString(String key) {
    Map<String, String> selectedLanguage = _getMapString();
    String text = key;
    if (selectedLanguage.containsKey(key) && selectedLanguage[key] != null) {
      text = selectedLanguage[key] ?? key;
    }
    return text;
  }

  static Map<String, String> _getMapString() {
    switch (Get.locale.toString()) {
      case localeCodeEn:
        return enStrings;
      default:
        return enStrings;
    }
  }
}
