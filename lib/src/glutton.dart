import 'package:glutton/src/glutton_digestion.dart';

class Glutton {
  static GluttonDigestion _digestion = GluttonDigestion();

  /// Save value inside glutton
  static Future<bool> eat(String key, dynamic value) async =>
      await _digestion.eat(key, value);

  /// Retrieve value inside glutton
  static Future<dynamic> vomit(String key, [dynamic defaultValue]) async =>
      await _digestion.vomit(key, defaultValue);

  /// Check if value with [key] exist
  /// Return true if the value is exist
  static Future<bool> have(String key) async => await _digestion.have(key);

  /// Remove selected value inside glutton
  static Future<bool> digest(String key) async => await _digestion.digest(key);

  /// Remove all value inside glutton
  static Future<bool> flush() async => await _digestion.flush();
}
