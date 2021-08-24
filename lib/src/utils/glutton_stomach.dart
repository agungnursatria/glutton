import 'package:shared_preferences/shared_preferences.dart';

class GluttonStomach {
  SharedPreferences? _storage;

  /// Save encrypted string data inside storage
  Future<bool> eat(String key, String value) async {
    await _validateStorage();
    return await _storage!.setString(key, value);
  }

  /// Retrieve encrypted data inside storage
  Future<dynamic> vomit(String key) async {
    await _validateStorage();
    return _storage!.get(key);
  }

  /// Remove data inside storage
  Future<bool> digest(String key) async {
    await _validateStorage();
    if (!_storage!.containsKey(key)) return false;
    return await _storage!.remove(key);
  }

  /// Remove all data inside storage
  Future<bool> flush() async {
    await _validateStorage();
    return await _storage!.clear();
  }

  /// Check if there is data inside storage using [key]
  /// Return true if contains value using [key]
  Future<bool> have(String key) async {
    await _validateStorage();
    return _storage!.containsKey(key);
  }

  /// Validate if storage has been initiated
  Future<void> _validateStorage() async {
    if (_storage == null) _storage = await SharedPreferences.getInstance();
  }
}