import 'dart:convert';

import 'package:glutton/src/exception/glutton_exception.dart';
import 'package:glutton/src/exception/glutton_format_exception.dart';
import 'package:glutton/src/exception/glutton_io_exception.dart';
import 'package:glutton/src/utils/glutton_constant.dart';
import 'package:glutton/src/utils/glutton_encrypter.dart';

class GluttonConverter {
  GluttonEncrypter _encrypter;
  GluttonConverter([GluttonEncrypter encrypter])
      : _encrypter = encrypter ?? GluttonEncrypter();

  String splitter = '--';

  /// Convert edible value to string
  String convert(dynamic value) {
    String prefix;
    String unEncryptedValue;

    try {
      if (value is List) {
        prefix = GluttonClassTypeConstant.List;
        unEncryptedValue = jsonEncode(value);
      } else if (value is Set) {
        prefix = GluttonClassTypeConstant.Set;
        unEncryptedValue = jsonEncode(value.toList());
      } else if (value is Map) {
        prefix = GluttonClassTypeConstant.Map;
        unEncryptedValue = jsonEncode(value);
      } else if (value is DateTime) {
        prefix = GluttonClassTypeConstant.DateTime;
        unEncryptedValue = value.toIso8601String();
      } else if (value is String) {
        prefix = GluttonClassTypeConstant.String;
        unEncryptedValue = value;
      } else if (value is int) {
        prefix = GluttonClassTypeConstant.Int;
        unEncryptedValue = value.toString();
      } else if (value is double) {
        prefix = GluttonClassTypeConstant.Double;
        unEncryptedValue = value.toString();
      } else if (value is bool) {
        prefix = GluttonClassTypeConstant.Bool;
        unEncryptedValue = value.toString();
      } else if (value is Uri) {
        prefix = GluttonClassTypeConstant.Uri;
        unEncryptedValue = value.toString();
      } else {
        throw GluttonFormatException(
          message: 'Wrong input, type ${value.runtimeType} is undefined',
        );
      }
    } catch (e, s) {
      if (e is GluttonException) throw e;
      throw GluttonIOException(message: e.toString(), stackTrace: s);
    }
    return _encrypter.encryptTwice('$prefix$splitter$unEncryptedValue');
  }

  /// Revert converted edible value to the real type
  dynamic revert(String encryptedValue) {
    if (encryptedValue == null)
      throw GluttonFormatException(
        message: 'Wrong input, cannot receive null value',
      );

    String decryptedValue = _encrypter.decryptTwice(encryptedValue);
    List splitted = decryptedValue.split(splitter);
    switch (splitted[0]) {
      case GluttonClassTypeConstant.List:
      case GluttonClassTypeConstant.Map:
        return jsonDecode(splitted[1]);
        break;
      case GluttonClassTypeConstant.Set:
        return jsonDecode(splitted[1]).toSet();
        break;
      case GluttonClassTypeConstant.DateTime:
        return DateTime.parse(splitted[1]);
        break;
      case GluttonClassTypeConstant.String:
        return DateTime.parse(splitted[1]);
        break;
      case GluttonClassTypeConstant.Int:
        return int.parse(splitted[1]);
        break;
      case GluttonClassTypeConstant.Double:
        return double.parse(splitted[1]);
        break;
      case GluttonClassTypeConstant.Bool:
        return splitted[1] == 'true';
        break;
      case GluttonClassTypeConstant.Uri:
        return Uri.parse(splitted[1]);
        break;
      default:
        throw GluttonFormatException(
          message: 'Wrong input, undefined class type',
        );
        break;
    }
  }
}
