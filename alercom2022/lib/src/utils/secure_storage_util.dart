import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final _storage = FlutterSecureStorage();

  static Future setStorageKey(String key, String value) async =>
      await _storage.write(key: key, value: value);

  static Future<String?> getStorageKey(String key) async {
    String value = await _storage.read(key: key) ?? '';
    return value;
  }
}
