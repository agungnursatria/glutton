import 'package:glutton/src/exception/glutton_format_exception.dart';
import 'package:glutton/src/utils/glutton_constant.dart';
import 'package:glutton/src/utils/glutton_converter.dart';
import 'package:glutton/src/utils/glutton_stomach.dart';
import 'package:glutton/src/utils/glutton_utils.dart';

class GluttonDigestion {
  late GluttonConverter _converter;
  late GluttonUtils _utils;
  late GluttonStomach _stomach;

  GluttonDigestion() {
    _utils = GluttonUtils();
    _converter = GluttonConverter(_utils);
    _stomach = GluttonStomach();
  }

  /// Check if value with [key] exist
  /// Return true if the value is exist
  Future<bool> have(String key) => _stomach.have(key);

  /// Remove selected value inside glutton stomach
  Future<bool> digest(String key) async => await _stomach.digest(key);

  /// Remove all value inside glutton stomach
  Future<bool> flush() async => await _stomach.flush();

  /// Save value inside glutton stomach
  Future<bool> eat(String key, dynamic value) async {
    /// throw GluttonFormatException if key or value is null or empty
    if (_utils.isNullOrEmpty(key) || _utils.isNullOrEmpty(value))
      throw GluttonFormatException(message: GluttonConstant.wrongInputError);

    /// Encrypt
    String convertedValue = _converter.convert(value);

    /// Save encrypted value inside glutton stomach
    /// Return true if eating is success
    return await _stomach.eat(key, convertedValue);
  }

  /// Retrieve value inside glutton stomach
  Future<dynamic> vomit(String key, [dynamic defaultValue]) async {
    /// throw GluttonFormatException if key or value is null or empty
    if (_utils.isNullOrEmpty(key))
      throw GluttonFormatException(message: GluttonConstant.wrongInputError);

    /// Retrieve encrypted value inside glutton stomach
    String convertedValue = await _stomach.vomit(key);

    /// Check if retrieved encrypted value exist
    /// Return defaultValue if encrypted value not exist
    if (_utils.isNullOrEmpty(convertedValue)) return defaultValue;

    /// Return unencrypted (real) value
    return _converter.revert(convertedValue);
  }
}
