import 'dart:convert';

import 'package:glutton/src/exception/glutton_exception.dart';
import 'package:glutton/src/exception/glutton_format_exception.dart';
import 'package:glutton/src/exception/glutton_io_exception.dart';
import 'package:glutton/src/utils/glutton_constant.dart';
import 'package:glutton/src/utils/glutton_encrypter.dart';
import 'package:glutton/src/utils/glutton_utils.dart';

class GluttonConverter {
  GluttonEncrypter _encrypter;
  GluttonUtils _utils;
  GluttonConverter(GluttonUtils utils, [GluttonEncrypter? encrypter])
      : _encrypter = encrypter ?? GluttonEncrypter(),
        _utils = utils;

  String splitter = '--';

  /// Convert edible value to string
  String convert(dynamic value) {
    String? type;
    String? innerType;
    String? unEncryptedValue;

    try {
      if (value is List) {
        type = GluttonClassTypeConstant.List;
        if (value.isNotEmpty && !_utils.isDynamicInnerValue(value))
          innerType = value.first.runtimeType.toString();
        unEncryptedValue = jsonEncode(value);
      } else if (value is Set) {
        type = GluttonClassTypeConstant.Set;
        if (value.isNotEmpty && !_utils.isDynamicInnerValue(value))
          innerType = value.first.runtimeType.toString();
        unEncryptedValue = jsonEncode(value.toList());
      } else if (value is Map) {
        type = GluttonClassTypeConstant.Map;
        unEncryptedValue = jsonEncode(value);
      } else if (value is DateTime) {
        type = GluttonClassTypeConstant.DateTime;
        unEncryptedValue = value.toIso8601String();
      } else if (value is String) {
        type = GluttonClassTypeConstant.String;
        unEncryptedValue = value;
      } else if (value is int) {
        type = GluttonClassTypeConstant.Int;
        unEncryptedValue = value.toString();
      } else if (value is double) {
        type = GluttonClassTypeConstant.Double;
        unEncryptedValue = value.toString();
      } else if (value is bool) {
        type = GluttonClassTypeConstant.Bool;
        unEncryptedValue = value.toString();
      } else if (value is Uri) {
        type = GluttonClassTypeConstant.Uri;
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
    return _encrypter
        .encryptTwice('$type$splitter$unEncryptedValue$splitter$innerType');
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
        List<dynamic> lst = jsonDecode(splitted[1]);
        switch (splitted[2]) {
          case 'int':
            return List<int>.from(lst);
          case 'String':
            return List<String>.from(lst);
          case 'bool':
            return List<bool>.from(lst);
          case 'double':
            return List<double>.from(lst);
            break;
          default:
            return lst;
        }
        break;
      case GluttonClassTypeConstant.Map:
        return jsonDecode(splitted[1]);
        break;
      case GluttonClassTypeConstant.Set:
        Set<dynamic> st = jsonDecode(splitted[1]).toSet();
        switch (splitted[2]) {
          case 'int':
            return Set<int>.from(st);
          case 'String':
            return Set<String>.from(st);
          case 'bool':
            return Set<bool>.from(st);
          case 'double':
            return Set<double>.from(st);
            break;
          default:
            return st;
        }
        break;
      case GluttonClassTypeConstant.DateTime:
        return DateTime.parse(splitted[1]);
        break;
      case GluttonClassTypeConstant.String:
        return splitted[1];
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