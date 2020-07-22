import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static Future<void> saveToken(token) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: "SecureToken", value: token.toString());
  }

  static Future<String> getToken() async {
    try {
      final storage = new FlutterSecureStorage();
      String value = await storage.read(key: "SecureToken");
      return value;
    } catch (e) {
      return null;
    }
  }

  /// ------ delete all --------
  static Future<void> deleteAllSecureData() async {
    final storage = new FlutterSecureStorage();
    await storage.deleteAll();
  }

  /// -------- write data-------
  static Future<void> writeSecureDataLocally({String key, String data}) async {
    final storage2 = new FlutterSecureStorage();
    await storage2.write(key: "$key", value: data.toString());
  }

  /// ------- read data ----------
  static Future<String> getSecureDataLocally({String key}) async {
    final storage2 = new FlutterSecureStorage();
    String value = await storage2.read(key: "$key");
    return value;
  }

  /// ------ get all data -------
  static Future<Map<String, String>> readAllSecureData() async {
    final storage = new FlutterSecureStorage();
    Map<String, String> allValues = await storage.readAll();
    return allValues;
  }
}
