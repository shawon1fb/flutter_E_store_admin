import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static writeDataLocally({String key, String value}) async {
    Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
    final SharedPreferences localData = await saveLocal;
    localData.setString(key, value);
  }

  static writeBoolDataLocally({String key, bool value}) async {
    Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
    final SharedPreferences localData = await saveLocal;
    localData.setBool(key, value);
  }

  static getDataLocally({String key}) async {
    Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
    final SharedPreferences localData = await saveLocal;
    return localData.get(key);
  }

  static getStringDataLocally({String key}) async {
    Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
    final SharedPreferences localData = await saveLocal;
    return localData.getString(key);
  }

  static getBoolDataLocally({String key}) async {
    Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
    final SharedPreferences localData = await saveLocal;
    return localData.getBool(key) == null ? false : localData.getBool(key);
  }

  static clearDataLocally() async {
    Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
    final SharedPreferences localData = await saveLocal;
    localData.clear();
  }
}
