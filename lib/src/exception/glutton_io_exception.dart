import 'package:glutton/src/exception/glutton_exception.dart';
import 'package:glutton/src/utils/glutton_constant.dart';

/// Occurence: Failed to converting value unidentified by GluttonFormatException
class GluttonIOException extends GluttonException {
  String _message;
  DateTime _time;
  StackTrace? _stackTrace;

  GluttonIOException({
    String? message,
    DateTime? time,
    StackTrace? stackTrace,
  })  : this._message = message ?? GluttonConstant.undefinedError,
        this._time = time ?? DateTime.now(),
        this._stackTrace = stackTrace;

  get message => _message;
  get time => _time;
  get stacktrace => _stackTrace;
}
