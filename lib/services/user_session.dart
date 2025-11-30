import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class UserSession {
  static const String key = "tempUserId";

  static Future<String> getTempUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? tempId = prefs.getString(key);

    if (tempId == null) {
      tempId = const Uuid().v4();
      await prefs.setString(key, tempId);
    }

    return tempId;
  }
}
